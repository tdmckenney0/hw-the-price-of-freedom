	-- Collect info
	--   determine money situation
	--   calc counters
	--   determine status vs other players
	
	-- Calc demands
	--   demands for each ship based on counters and other factors
	--   demands for subsystems based on the need for ships
	--   demands for research based on many factors
	
	-- Process demands
	--  build per buildship, research
	
	
	-- other rules
	--   set military flags based on current game state
	--   change attack defend priorities based on current game state
	--   set resourcing flags based on current game state
	--   set tactic flags based on current game state
	--   

aitrace("DEFAULT CPU LOADED")

-- level of difficulty global variable
g_LOD = getLevelOfDifficulty()

-- adds a bunch of class definitions for all ships and subsystems
dofilepath("data:ai/classdef.lua")
-- handles building ships and subsystems
dofilepath("data:ai/cpubuild.lua")
-- handles researching
dofilepath("data:ai/cpuresearch.lua")
-- handles military
dofilepath("data:ai/cpumilitary.lua")

-- removes all aitrace calls
 	old_aitrace = aitrace
 	rawset(globals(),"aitrace",nil)
 	aitrace = function() end


-- main init called from the code (hook)
function oninit()
	
	-- store the players index and race so we don't call these funcs all the time
	s_playerIndex = Player_Self()
	s_race = getRace();
	
	-- global flag init
	sg_dobuild = 1
	sg_dosubsystems = 1
	sg_doresearch = 1
	sg_doupgrades = 1
	sg_domilitary = 1
	cp_processResource = 1
	cp_processMilitary = 1
	
	-- how often does the AI spend time thinking about buying stuff
	sg_lastSpendMoneyTime = gameTime()
	sg_spendMoneyDelay = 0
	if (g_LOD < 2) then
		sg_spendMoneyDelay = 4
		if (g_LOD < 1) then
			sg_spendMoneyDelay = 8
		end
	end
	
	-- initialize all the classes - within classdef.lua
	ClassInitialize()
		
	-- initialize the build rule system
	CpuBuild_Init()
	-- initialize the research rule system
	CpuResearch_Init()
	-- initialize the military rule system
	CpuMilitary_Init()
	
	-- research demand is used to give research a try every X ships/subsystems
	-- eg. vaygr need research more, so they re-evalulate research every 2 cycles
	sg_kDemandResetValue = 4
	if (s_race == Race_Vaygr) then
		sg_kDemandResetValue = 2
	end
	
	-- override the init process
	if (Override_Init) then
		Override_Init()
	end
		
	sg_reseachDemand = -sg_kDemandResetValue
	
	-- add the main process/update rule
	Rule_AddInterval("doai", 2.0 )
		
end

function CalcOpenBuildChannels()


	
	-- determine if we should add another ship into the build system - could also cancel unneeded items that are only just started
	--local numShipsBuilding = NumShipsBuilding()
	
	local numShipsBuildingShips = NumShipsBuildingShips()
	local numShipsBuildingSubSystems = NumShipsBuildingSubSystems()
	
	-- get total number of buildqueue items being built
	local numShipsBuilding = numShipsBuildingShips + numShipsBuildingSubSystems
	
	-- get total number of build items
	local researchItem = IsResearchBusy()
	local numItemsBuilding = numShipsBuilding + researchItem
	
	-- each ship has two channels, 1) ships 2) subsystems
	local totalBuildShips = BuildShipCount()*2
		
	local numCollecting = GetNumCollecting()
	local numRUs = GetRU()
	
	-- how many ships can we allow to build - 1 ship for every 5 collectors 
	sg_allowedBuildChannels = numCollecting/5;
	
	-- if we are researching then reduce the build channel by one half
	-- and you can build even more for every 1000 bucks the cpu player has over 1000 ru's
	if (numRUs > 500) then
		sg_allowedBuildChannels = sg_allowedBuildChannels + (numRUs-500)/1000
	end
		
	-- how many more items are we building then we are allowed
	s_numOpenBuildChannels = sg_allowedBuildChannels - numItemsBuilding
	
	-- determine if all of our ships are full of stuff
	s_shipBuildQueuesFull = 0
	if (totalBuildShips == numShipsBuilding) then
		s_shipBuildQueuesFull  = 1
	end
	
	-- do we NEED a ship right now badly - if so then lets see if we should pause or cancel
	-- any of the build channels
	if (s_numOpenBuildChannels <= -1.5) then
		
		RemoveLeastNeededItem()
		--s_numOpenBuildChannels = s_numOpenBuildChannels + CancelBuildFunc()
	end

end

function CacheCurrentState()

	-- CACHE subsystem variables
	-- get the number of each subsystem there is
	s_numFiSystems = NumSubSystems(FIGHTERPRODUCTION) + NumSubSystemsQ(FIGHTERPRODUCTION)
	s_numCoSystems = NumSubSystems(CORVETTEPRODUCTION) + NumSubSystemsQ(CORVETTEPRODUCTION)
	s_numFrSystems = NumSubSystems(FRIGATEPRODUCTION) + NumSubSystemsQ(FRIGATEPRODUCTION)
	s_totalProdSS = s_numFiSystems + s_numCoSystems + s_numFrSystems
	
	-- CACHE military variables
	-- get the local players current military population
	s_militaryPop = PlayersMilitaryPopulation( s_playerIndex, player_total );
	
	-- get the AIs military value
	s_selfTotalValue = PlayersMilitary_Total( s_playerIndex, player_total );
	s_enemyTotalValue = PlayersMilitary_Total( player_enemy, player_max );
	
	-- get the military threat versus all enemies (higher the better the AI is against its enemy - uses counters in compare)
	s_militaryStrength = PlayersMilitary_Threat( player_enemy, player_min ); -- should be player_min
	
	-- get the current chosen enemy target
	s_enemyIndex = GetChosenEnemy()
	
	-- get our strength versus this target (includes counters)
	s_militaryStrengthVersusTarget = 0
	if (s_enemyIndex ~= -1) then
		s_militaryStrengthVersusTarget = PlayersMilitary_Threat( s_enemyIndex, player_max )
	end
	
end

function SpendMoney()

	-- check cached var that lets us know if we can build or not based on number of build channels
	if (s_numOpenBuildChannels > 0) then
	
		-- since _Process gets called twice this is here to make sure its only called once
		local buildHasBeenDone = 0
		
		-- if flag for building is on and our ships aren't completely full then attempt to build
		if (sg_dobuild==1 and s_shipBuildQueuesFull==0 and sg_reseachDemand<0) then
			if (CpuBuild_Process() == 1) then
				-- we build something so decrease build channel
				s_numOpenBuildChannels = s_numOpenBuildChannels-1
				
				sg_reseachDemand = sg_reseachDemand + 1
				
				buildHasBeenDone = 1
			end
		end
		
		-- if channels are still open even after the build process function go ahead and research
		if (s_numOpenBuildChannels > 0) then
			-- don't research unless we have a certain amount of resourcers and a certain military
			if (sg_doresearch==1) then
				
				local didResearch = CpuResearch_Process();
				
				-- check to see if we did some research
				if (didResearch == 1) then
					-- reset the research demand
					sg_reseachDemand = -sg_kDemandResetValue
				else
					-- since we didn't do research see if we can build a ship/subsys instead
					if (sg_reseachDemand>=0 and sg_dobuild==1 and s_shipBuildQueuesFull==0 and buildHasBeenDone == 0) then
						-- give the ship building another try
						CpuBuild_Process()
					end
				end
			else
				sg_reseachDemand = -sg_kDemandResetValue
			end
		end
	end
	
end

-- main process function called from code on a timer interval
function doai()

	-- cache vars that are used multiple times per cpu frame
	CacheCurrentState();
	
	-- calc the number of open build channels
	CalcOpenBuildChannels();

	local curTime = gameTime()
	local timeSinceLastSubSysDemand = curTime - sg_lastSpendMoneyTime
	
	if (timeSinceLastSubSysDemand >= sg_spendMoneyDelay) then
		-- build ships, subsystems and research
		SpendMoney()
		
		-- reset the spend money timer
		sg_lastSpendMoneyTime = curTime
	end
	
	--
	-- Do military - set targets, choose enemies, set group sizes
	if (sg_domilitary==1) then
		CpuMilitary_Process();
	end
	
		
end



