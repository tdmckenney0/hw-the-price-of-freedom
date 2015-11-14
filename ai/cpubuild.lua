-- CpuBuild.lua
--
--  This file is responsible for determining what the CPU player should be building (ships) Subsystems are handled in a seperate module
--  The basic process is to determine the demand for each ship then pick the best available one.
--  

aitrace("LOADING CPU BUILD")

dofilepath("data:ai/cpuresource.lua")
dofilepath("data:ai/cpubuildsubsystem.lua")

function CreateBuildDefinitions()

	-- these definitions are for building the specific ships
	-- you should also be able to build from class types (like eFighter)
	
	-- these are used for building
	if (s_race == Race_Hiigaran) then
	
		kCollector = HGN_RESOURCECOLLECTOR
		kRefinery  = HGN_RESOURCECONTROLLER
		kScout = HGN_SCOUT
		kInterceptor = HGN_INTERCEPTOR
		kBomber = HGN_ATTACKBOMBER
		kCarrier = HGN_CARRIER
		kShipYard = HGN_SUPERCARRIER
		kDestroyer = HGN_DESTROYER
		kHeavyDestroyer = HGN_DESTROYER
		kRanger = HGN_CROSSBOW_CRUISER
		kCQB = HGN_SWORD_CRUISER
		kBattleCruiser = HGN_BATTLECRUISER
		kBattleShip = HGN_BATTLESHIP
		
	else
	
		kCollector = VGR_RESOURCECOLLECTOR
		kRefinery  = VGR_RESOURCECONTROLLER
		kScout = VGR_SCOUT
		kInterceptor = VGR_INTERCEPTOR
		kBomber = VGR_BOMBER
		kCarrier = VGR_CARRIER
		kShipYard = VGR_SHIPYARD
		kDestroyer = VGR_DESTROYER
		kHeavyDestroyer = VGR_HELIOS
		kRanger = VGR_DREADNAUGHT
		kCQB = VGR_HELIOS
		kBattleCruiser = VGR_BATTLECRUISER
		kBattleShip = VGR_BATTLESHIP
		
	end
	
end

-- personality demand is demand that is applied throughout the duration of a game
-- its really a player preference for ships. These numbers are usually very low so that they don't severyly
-- interfere with the rest of the demand values (counter system, ...)
function CpuBuild_PersonalityDemand()

	if (s_race == Race_Hiigaran) then
		sg_classPersonalityDemand[ eFighter ] = 0.5
		sg_classPersonalityDemand[ eCorvette ] = 0.25
		sg_classPersonalityDemand[ eFrigate ] = 0.0
	else
		sg_classPersonalityDemand[ eFighter ] = 0.5
		sg_classPersonalityDemand[ eCorvette ] = 0.5
		sg_classPersonalityDemand[ eFrigate ] = 0.25
	end
	
	-- decrease demand for platforms - they are currently only requested during the counter-demand-phase (as anti-this and that)
	sg_classPersonalityDemand[ ePlatform ] = -0.5
	if (Rand(100) < 10) then
		sg_classPersonalityDemand[ ePlatform ] = 0
	end
	if (g_LOD >= 2) then
		sg_classPersonalityDemand[ ePlatform ] = sg_classPersonalityDemand[ ePlatform ] - 3.0
	end
	
	aitrace("PersonalityDemand: Fi:"..sg_classPersonalityDemand[ eFighter ].." Co:"..sg_classPersonalityDemand[ eCorvette ].." Fr:"..sg_classPersonalityDemand[ eFrigate ])

end

-- Main initialization function for this component of CPU player
function CpuBuild_Init()
	
	-- creates a list of variaibles that are race independant (eg. kInterception instead of Vgr_Int.. and Hgr_Interceptor)
	CreateBuildDefinitions()
	
	-- initialize any info that is needed for building subsystems
	CpuBuildSS_Init()
	
	-- initialize resource building info
	CpuResource_Init()
	
	-- top most demand classes
	sg_resourceDemand = 1
	sg_scoutDemand = 0
	sg_militaryDemand = 1
	
	-- randomly offset the time when the first AI scout is built
	sg_randScoutStartBuildTime = 30+Rand(120)
	-- randomly set how this AI will favor his/her ships
	sg_randFavorShipType = Rand(100)
	
	-- personality demand table - used to hold the demand offsets for this particular AI player
	sg_classPersonalityDemand = {}
	-- hand out some demand for each class
	CpuBuild_PersonalityDemand()
	
	sg_subSystemOverflowDemand = 0
	sg_subSystemDemand = 0
	sg_shipDemand = 4

    -- drives the resource build, it governs how many military units to build before building another collector
	sg_militaryToBuildPerCollector = 0
	
	-- based on the level of difficulty determine which set of rules will be called for calculating ship demands
	if (g_LOD == 0) then
		CpuBuild_DefaultShipDemandRules = CpuBuild_DefaultShipDemandRules_Easy
	elseif (g_LOD == 1) then
		CpuBuild_DefaultShipDemandRules = CpuBuild_DefaultShipDemandRules_Med
	else
		CpuBuild_DefaultShipDemandRules = CpuBuild_DefaultShipDemandRules_Hard
	end
	
	-- how much randomness is there in the choosing of ships and subsystems
	cp_shipDemandRange = 0.5
	cp_subSystemDemandRange = 0.5
	if (g_LOD == 1) then
		cp_shipDemandRange = 1
		cp_subSystemDemandRange = 1
	end
	if (g_LOD == 0) then
		cp_shipDemandRange = 2
		cp_subSystemDemandRange = 2
	end
	
	-- call an external function that overrides any of the above demand values
	if (Override_BuildDemandInit) then
		Override_BuildDemandInit()
	end
	
	kUnitCapId_Fighter = GetUnitCapFamilyId("Fighter")
	kUnitCapId_Corvette = GetUnitCapFamilyId("Corvette")
	kUnitCapId_Frigate = GetUnitCapFamilyId("Frigate")
	
end

function DetermineClassDemand()

	for i=0, eMaxCount do
	
		if (sg_classPersonalityDemand[ i ] and sg_classPersonalityDemand[ i ]~=0) then
			ShipDemandSetByClass( i, sg_classPersonalityDemand[ i ] );
		end
	
	end
	
	----TEMP----
	-- reduce the demand for some ships that are not support - nor provide any benefits to the AI at this point
	ShipDemandSetByClass( eUselessShips, -10 )
	
end

-- what type of anti-chassis ships do i want to build - use enemies chassis values minus our current anti-chassis values to determine this
function DetermineAntiChassisDemand(enemyIndex)
	
	local kFighterCounterScale = 3.0
	local kCorvetteCounterScale = 1.5
	local kFrigateCounterScale = 1.0
	
	local AFiDemand=0
	local ACoDemand=0
	local AFrDemand=0
	
	-- fighter demand
	local FiValue = PlayersMilitary_Fighter(enemyIndex, player_max)
	local self_AFiValue = PlayersMilitary_AntiFighter(s_playerIndex, player_max)
	-- was FiValue*kFighterCounterScale - self_AFiValue = which I don't believe was proper
	local enemy_FiTotal = (FiValue-self_AFiValue)*kFighterCounterScale
	-- does enemy have more fighters by X% then we have antiFighter power?
	if (enemy_FiTotal < 0) then
		enemy_FiTotal = 0
	end
	
	-- corvette demand
	local CoValue = PlayersMilitary_Corvette(enemyIndex, player_max)
	local self_ACoValue = PlayersMilitary_AntiCorvette(s_playerIndex, player_max)
	-- was CoValue*kCorvetteCounterScale - self_ACoValue
	local enemy_CoTotal = (CoValue - self_ACoValue)*kCorvetteCounterScale
	-- does enemy have more corvettes then we have antiCorvette power?
	if (enemy_CoTotal < 0) then
		enemy_CoTotal = 0
	end
	
	-- don't count the enemys mothership's frig score when it has
	local MSfrig_correction = 0
	-- if our strength is less then 20 meaning we are weak then remove X frig points which is equivalent to a MotherShip
	if (s_militaryStrengthVersusTarget < 20) then
		MSfrig_correction = 25
	end
	
	-- frigate demand
	local FrValue = PlayersMilitary_Frigate(enemyIndex, player_max) - MSfrig_correction
	local self_AFrValue = PlayersMilitary_AntiFrigate(s_playerIndex, player_max)
	-- was FrValue*kFrigateCounterScale - self_AFrValue
	local enemy_FrTotal = (FrValue - self_AFrValue)*kFrigateCounterScale
	-- does enemy have more frigs then we have antiFrig power?
	if (enemy_FrTotal < 0) then
		enemy_FrTotal = 0
	end
	
	local enemy_ChassisTotal = enemy_FiTotal + enemy_CoTotal + enemy_FrTotal
	-- if this is positive that means the enemy has more chassis value over our anti-chassis values
	if (enemy_ChassisTotal > 0) then
		-- check to see where we need some more anti-chassis improvements
		if (enemy_FiTotal > 0) then
			local FiTotalPercent = enemy_FiTotal*100/enemy_ChassisTotal
			if (FiTotalPercent > 70) then
				AFiDemand = AFiDemand + 3
			elseif (FiTotalPercent > 35) then
				AFiDemand = AFiDemand + 1.5
			end
		end
		if (enemy_CoTotal > 0) then
			local CoTotalPercent = enemy_CoTotal*100/enemy_ChassisTotal
			if (CoTotalPercent > 70) then
				ACoDemand = ACoDemand + 3
			elseif (CoTotalPercent > 35) then
				ACoDemand = ACoDemand + 1.5
			end
		end
		if (enemy_FrTotal > 0) then
			local FrTotalPercent = enemy_FrTotal*100/enemy_ChassisTotal
			if (FrTotalPercent > 70) then
				AFrDemand = AFrDemand + 3
			elseif (FrTotalPercent > 35) then
				AFrDemand = AFrDemand + 1.5
			end
		end
	end
	
	-- seperate from above rules incase new rules are added
	if (AFiDemand > 0) then
		ShipDemandAddByClass( eAntiFighter, AFiDemand )
	end
	if (ACoDemand > 0) then
		ShipDemandAddByClass( eAntiCorvette, ACoDemand )
	end
	if (AFrDemand > 0) then
		ShipDemandAddByClass( eAntiFrigate, AFrDemand )
	end
	
	aitrace("AChDmd: AFi:"..AFiDemand.." ACo:"..ACoDemand.." AFr:"..AFrDemand)
end

-- what type of chassis do i want to build or avoid - use enemies anti-chassis values to determine this
function DetermineChassisDemand(enemyIndex)
	
	local FiDemand=0
	local CoDemand=0
	local FrDemand=0

	-- antifighter
	local AFiValue = PlayersMilitary_AntiFighter(enemyIndex, player_max)
	local ACoValue = PlayersMilitary_AntiCorvette(enemyIndex, player_max)
	local AFrValue = PlayersMilitary_AntiFrigate(enemyIndex, player_max)
	local ATotal = AFiValue + ACoValue + AFrValue
	if (ATotal <= 0) then
		return
	end
	
	if (AFiValue > 5) then
		local AFiPercent = AFiValue*100/ATotal
		if (AFiPercent > 70) then
			FiDemand = FiDemand - 3
		elseif (AFiPercent > 35) then
			FiDemand = FiDemand - 1.5
		end
	end
	
	if (ACoValue > 5) then
		local ACoPercent = ACoValue*100/ATotal
		if (ACoPercent > 70) then
			CoDemand = CoDemand - 2
		elseif (ACoPercent > 35) then
			CoDemand = CoDemand - 1
		end
	end
	
	if (AFrValue > 5) then
		local AFrPercent = AFrValue*100/ATotal
		if (AFrPercent > 70) then
			FrDemand = FrDemand - 1.5
		elseif (AFrPercent > 35) then
			FrDemand = FrDemand - 0.5
		end
	end
	
	-- modify demand for each class (note: can be negative)
	ShipDemandAddByClass( eFighter, FiDemand )
	ShipDemandAddByClass( eCorvette, CoDemand )
	ShipDemandAddByClass( eFrigate, FrDemand )

	aitrace("ChDmd: Fi:"..FiDemand.." Co:"..CoDemand.." Fr:"..FrDemand)
	
end

-- call this function when the enemy doesn't have many ships so there is not much use doing counters
function DetermineDemandWithNoCounterInfo()

	-- if AI doesn't have many ships yet - then pick randomly for a starting fleet
	-- once AI does have some ships and the enemy still doesn't have many - build antifrigates
	if (s_militaryPop < 5) then
	
		aitrace("Dmd:Rand:"..sg_randFavorShipType )
		
		if (s_race == Race_Hiigaran) then
			if (sg_randFavorShipType < 55) then
				ShipDemandAddByClass( eFighter, 1 )
			elseif (sg_randFavorShipType < 85) then
				ShipDemandAddByClass( eCorvette, 1 )
			elseif (g_LOD < 2 and sg_randFavorShipType < 95) then
				ShipDemandAddByClass( eFrigate, 1 )
			else
				ShipDemandAdd( kDestroyer, 2.0 )
				ShipDemandAdd( kHeavyDestroyer, 1.0 )
			end
		else
			if (sg_randFavorShipType < 45) then
				ShipDemandAddByClass( eFighter, 1 )
			elseif (sg_randFavorShipType < 75) then
				ShipDemandAddByClass( eCorvette, 1 )
			-- frigates are not the best hiigaran choice but for now I'll leave the 3-way balance 
			else
				ShipDemandAddByClass( eFrigate, 1 )
			end
		end
	else
	
		aitrace("Dmd:Asking for AntiFrigates" )
		-- go for anti frigate ships since enemy has no protectors for his 
		-- precious capital ships
		ShipDemandAddByClass( eAntiFrigate, 1.5 )
	
	end

end

-- take the intel about our enemies and midify the demand for ships
function DetermineCounterDemand()
	
	-------------------------------------------------------------------------
	-- get the current targeted enemy
	if (s_enemyIndex ~= -1) then
		-- quick check to make sure enemy has some units
		local enemyMilitaryCount = PlayersMilitaryPopulation( s_enemyIndex, player_max )
		if (enemyMilitaryCount >= 3) then -- could increase this number (should have a few ships before counters start calculating)
			
			-- do counter demand here
			DetermineChassisDemand(s_enemyIndex)
			DetermineAntiChassisDemand(s_enemyIndex)
			
			-- if our strength versus our target is very high we should do the counters plus some of our persuasion
			-- so if we have a low strenght (below some value) then we should return not running the
			-- random ship chooser
			--if (s_militaryStrengthVersusTarget < 150) then
				return
			--end
			
		end
	end
	
	
	
	-- if we are here its because the enemy does not have many ships - so no counter calcs
	DetermineDemandWithNoCounterInfo();
	

end

function DetermineSpecialDemand()
	
	-- TODO: check the percentage of ships this AI has a balance them out, if they have more then X% of a ship type 
	-- then decrease the demand for that shiptype (don't do this when under attack though)
	-- TODO: if player has lots of money and isn't under attack, add bonus' to more expensive units
		
	-- special rule to increase corvette/frigate production over interceptor production
	-- counter system should balance this out - but current there is no quality checks
--~ 	if (NumSubSystems(CORVETTEPRODUCTION)>0 or NumSubSystems(FRIGATEPRODUCTION)>0) then
--~ 		-- interceptors are pretty weak so don't build more than 4 (or atleast decrease demand drastically)
--~ 		-- it would be better to build assault corvs or frigs
--~ 		if  (NumSquadrons(kInterceptor)>4) then
--~ 			ShipDemandAdd( kInterceptor, -1 )
--~ 		end
--~ 		local numFighters = numQueueOfClass( eFighter )
--~ 		if (numFighters >= 5) then
--~ 			-- if we have more then X fighters decrease the demand for this type of class
--~ 			  ShipDemandAddByClass( eFighter, (-numFighters/5) - 0.5)
--~ 		end
--~ 	end

	-- if we already have a fighter production factility - and we have less than 3 interceptors put more demand on them
	-- if we also have less than 10 ships (early game)
	if (ShipDemandGet( kInterceptor ) > 0 and NumSubSystems(FIGHTERPRODUCTION) > 0 and NumSquadrons(kInterceptor) < 3 and s_militaryPop < 10) then
		ShipDemandAdd( kInterceptor, 0.5 )
	end

	-- once we have a bit more military then add a frigate base value
	if (s_selfTotalValue > 120) then
		local additionalFrigDemand = 0.5
		if (s_race == Race_Hiigaran) then
			local advresearchcount = NumSubSystems(ADVANCEDRESEARCH) + NumSubSystemsQ(ADVANCEDRESEARCH)
			if (advresearchcount > 0) then
				additionalFrigDemand = additionalFrigDemand + 0.25
			end
		end
		
		ShipDemandAddByClass( eFrigate, additionalFrigDemand )
		-- removes the initial bonus for fighters
		ShipDemandAddByClass( eFighter, -0.5 )
		
	end
	
    -- tweak the demand for special frigates based on our military strength,
    -- we already count these frigates as anti frigate so the fleet vs
    -- fleet stuff is already done
    
    -- first see if we have too many special frigates compared to the normal ones
    local numSpecial = numQueueOfClass(eCapture) + numQueueOfClass(eShield)
    local numFrigates = numQueueOfClass(eFrigate)
    if(numFrigates == 0 or numSpecial / numFrigates > 0.4) then
        -- too many, floor the demand
        ShipDemandAddByClass( eCapture, -10 )
        ShipDemandAddByClass( eShield, -10 )        
    else
        -- not too many, so based on the size of our fleet tweak the demand
        if (s_militaryPop < 5) then
            ShipDemandAddByClass( eCapture, -4 )
            ShipDemandAddByClass( eShield, -4.5 )
        elseif (s_militaryPop < 10) then
            ShipDemandAddByClass( eCapture, -2 )
            ShipDemandAddByClass( eShield, -2.5 )
        elseif (s_militaryPop < 15) then
            ShipDemandAddByClass( eCapture, -1 )
            ShipDemandAddByClass( eShield, -1.5 )
        elseif (s_militaryPop > 30) then
            ShipDemandAddByClass( eCapture, 1 )
            ShipDemandAddByClass( eShield, 1 )
		end
    end
    
	-- torpedo frigate is a bit useless until we get the upgrade
	-- but the upgrade doesn't come unless we have lots of torpedo frigs
	if (s_race == Race_Hiigaran) then
		local torpedoDemand = -0.5
		-- if we have the upgrade or we are winning or we have tons of money
		if (IsResearchDone(IMPROVEDTORPEDO) == 1 or s_militaryStrength > 40 or GetRU() > 2500) then
			torpedoDemand = 0
		end
		ShipDemandAdd( HGN_TORPEDOFRIGATE, torpedoDemand )
	end
	
	local numRUs = GetRU()
    -- always add some demand for these two ships - if we are economically sound
	if ( (GetNumCollecting() > 9 or numRUs > 1500) and s_militaryPop > 8 and UnderAttackThreat() < -75) then
		ShipDemandAdd( kBattleCruiser, 0.75 )
		ShipDemandAdd( kDestroyer, 0.25 )
		ShipDemandAdd( kHeavyDestroyer, 0.35 )
		ShipDemandAdd( kCQB, 0.5 )
		ShipDemandAdd( kRanger, 0.5 )
		-- more want for battle cruiser if we aren't currently under huge attack
		if (IsResearchDone( BATTLECRUISERIONWEAPONS ) == 1) then
			ShipDemandAdd( kBattleCruiser, 0.5 )
			ShipDemandAdd( kBattleShip, 1.0 )
			
		end
	end
		
	-- if enemy has battlecruisers we should increase the request for subsystem attackers
	local numEnemyBattleCruisers = PlayersUnitTypeCount( player_enemy, player_total, eBattleCruiser )
	if (numEnemyBattleCruisers > 0) then
		
		local ssKillaDemand = numEnemyBattleCruisers/2
		
		if (s_enemyIndex ~= -1) then
			local targetEnemyCruisers = PlayersUnitTypeCount( s_enemyIndex, player_max, eBattleCruiser )
			if (targetEnemyCruisers > 0) then
				ssKillaDemand = ssKillaDemand + targetEnemyCruisers
				
			end
		end
		
		ShipDemandAddByClass( eSubSystemAttackers, ssKillaDemand )
		
	end
	
	-- add more demand to shipyards if we have none
	local numShipyards = NumSquadrons( kShipYard ) + NumSquadronsQ( kShipYard )
	if (numShipyards == 0 and UnderAttackThreat() < -75) then
		local bcDemand = ShipDemandGet( kBattleCruiser )
		if (bcDemand >= 0.5) then
			ShipDemandAdd( kShipYard, bcDemand-0.5 )
		end
	end
	
	-- if AI is winning the militaryvalue battle reduce platform demand
	if (s_militaryStrength > 25*sg_moreEnemies) then
		ShipDemandAddByClass( ePlatform, -2 )
	end
end

-- this function is used to calculate a military value the AI should aim for.
function CalculateMilitaryValueGoal( militaryTable, percentOfEnemy )

	local curTime = gameTime()
	local minMilitaryValue = 0
	
	-- if an enemy in the world exceeds or bare minimum value - then up or military value goal
	if (s_enemyTotalValue*percentOfEnemy > minMilitaryValue) then
		minMilitaryValue = s_enemyTotalValue*percentOfEnemy
	end
	
	for k,v in militaryTable do
	
		if (curTime < v[3]) then
			-- make sure value doesn't drop below v[1]
			if (minMilitaryValue < v[1]) then
				minMilitaryValue = v[1]
			end
			-- make sure value doesn't exceed v[2]
			if (minMilitaryValue > v[2]) then
				minMilitaryValue = v[2]
			end
			break
		end
	
	end
	
	return minMilitaryValue

end

function CpuBuild_DefaultShipDemandRules_Easy()
	
	local valueTable = 
	{
		-- min value, max value, time cap
		{80, 		135, 		8*60},
		{120,		180,		15*60},
		{160,		230,		20*60},
		{220,		300,		30*60},
		{270,		370,		45*60},
		{350,		500,		60*60},
		{500,		1000,		10000*60},
	}
	
	local minMilitaryValue = CalculateMilitaryValueGoal( valueTable, 0.7 )
	
	aitrace("Aim:"..minMilitaryValue.." CurMil:"..s_selfTotalValue.." Enm:"..s_enemyTotalValue )
	
	-- if we are lower then our goal then do the counter value stuff
	if (s_selfTotalValue < minMilitaryValue) then
		DetermineClassDemand();
		DetermineCounterDemand();
		DetermineSpecialDemand();
	end
	
	DetermineScoutDemand();
	DetermineBuilderClassDemand();
		
end

function CpuBuild_DefaultShipDemandRules_Med()
	
	local valueTable = 
	{
		-- min value, max value, time cap
		{120, 	200, 		8*60},
		{160,		250,		15*60},
		{220,		320,		20*60},
		{280,		400,		30*60},
		{320,		500,		45*60},
		{500,		700,		60*60},
		{700,		1200,		10000*60},
	}
	
	local minMilitaryValue = CalculateMilitaryValueGoal( valueTable, 0.85 )
	
	aitrace("Aim:"..minMilitaryValue.." CurMil:"..s_selfTotalValue.." Enm:"..s_enemyTotalValue )
	
	-- if we are lower then our goal then do the counter value stuff
	if (s_selfTotalValue < minMilitaryValue) then
		DetermineClassDemand();
		DetermineCounterDemand();
		DetermineSpecialDemand();
	end
	
	DetermineScoutDemand();
	DetermineBuilderClassDemand();
	
end

function CpuBuild_DefaultShipDemandRules_Hard()
	
	DetermineClassDemand();
	DetermineCounterDemand();
	DetermineScoutDemand();
	DetermineBuilderClassDemand();
	DetermineSpecialDemand();	
	
end


function CpuBuild_RemoveBuildItems()
	
	RemoveStalledBuildItems()
	
end

-- Main processing function for this component of CPU player (called with doai in the main module)
function CpuBuild_Process()

	--aitrace("*CpuBuild_Process")
	ShipDemandClear()
	
	--
	-- If all build channels are full - and our money is tight then we may need to remove from
	-- a build channel, first check research, then so on (subs and ships)
	CpuBuild_RemoveBuildItems()
	
	-- class based demand rules
	if (Override_ShipDemand) then
		
		Override_ShipDemand()
		
	else
	
		-- all the default demand calculating functions
		CpuBuild_DefaultShipDemandRules()
	
	end
	
		
	if (sg_resourceDemand > 0 or sg_militaryDemand <= 0) then
		--aitrace("**DoResourceBuild")
		if (DoResourceBuild()==1) then
			-- we've successfully queued something, set the delay till we do this again
			sg_resourceDemand = 1 - sg_militaryToBuildPerCollector
			--aitrace("resbuild")
			return 1
		end
	end
	
	if (sg_militaryDemand > 0) then
		aitrace("**DoMilitaryBuild")
		if (DoMilitaryBuild()==1) then
			-- we've managed to queue something for the military, if the resourcing demand is set to delay them then increment it
			if(sg_resourceDemand <= 0) then
				sg_resourceDemand = sg_resourceDemand + 1
				--aitrace("milbuild")
			end
			return 1
		end
	end
	
	return 0

end

-- military choices
function DoMilitaryBuild()

	-- add all the subsystem demand variables together - negate this if we are underattack and the chosen ship
	-- has a high enough demand value to be effective
	local ssDemand = sg_subSystemDemand + sg_subSystemOverflowDemand + (Rand(3)-1)
	
	--aitrace("ShipDmd:"..sg_shipDemand.." Sub:"..ssDemand)
	
	-- do we produce a ship ?
	local shipId = FindHighDemandShip()
	local highestPriority = HighestPriorityShip()
	
	-- if we are underattack with a threat greater then -10 (a couple bomber difference)
	-- how does money play into this, or number of build slots available
	if (UnderAttackThreat() > -5 and shipId > 0 and highestPriority >= 0.5) then
		-- reset subsys demand to force another ship to be built instead
		-- of another subsystem
		ssDemand = 0
		aitrace("Subsys demand reduced because we are under attack")
	end
	
	
	if (sg_shipDemand > ssDemand) then
		
		--aitrace("Build:ShipId:"..shipId.." Pri:"..highestPriority )
		if (shipId > 0) then
			-- build the selected military ship
			--aitrace("Build:Attempt")
			Build( shipId )
			-- increase the chance a subsystem will be picked next time
			sg_subSystemOverflowDemand = sg_subSystemOverflowDemand + 1
			
			return 1
		end
		
	end
	
	-- do all the subsystem demand and build choices
	if (sg_dosubsystems == 1 and CpuBuildSS_DoBuildSubSystem() == 1) then
		return 1
	end
		
	-- nothing was chosen if we get here
	return 0
end

function DetermineScoutDemand()

	local curGameTime = gameTime()
	-- only build scouts when there isn't major threat	and after the random timer
	if (UnderAttackThreat() < -10 and s_militaryPop > 0 and curGameTime > sg_randScoutStartBuildTime) then
			
		local numEnemies = PlayersAlive( player_enemy )
		local shipCount = numQueueOfClass( eScout )
		
		-- if we want more than 2 scouts make sure we have the military to back them
		local numScoutsDemanded = 1
		if (numEnemies >= 2) then
			numScoutsDemanded = 2
		end
		if (numEnemies > 2 and s_militaryPop > 7) then
			numScoutsDemanded = 2+((s_militaryPop-7)/10)
		end
		
		--aitrace("Scout:Dem:"..numScoutsDemanded.." Num:"..shipCount )
				
		-- do we have the amount we are looking for
		if (shipCount < numScoutsDemanded) then
			
			ShipDemandAddByClass( eScout, 3.5 ) -- add a general scouting bonus - by personality
			
			local scoutRand = Rand(100)
			if (scoutRand > 30) then
				ShipDemandAdd( kScout, 1.5 ) -- add a general scouting bonus - by personality
			end
			
			-- everytime a scout is demand increase the next demand time by X seconds
			sg_randScoutStartBuildTime = curGameTime + 50
		end
		
	end
end



-- this is an overriding rule - it ignores the desire system and build an item directly because
-- of its high need
function DetermineBuilderClassDemand()

	-- TODO: check to see how many unitcap slots are left - if very little no need for new 
	-- carrier. 
	
	local numBuilders = numQueueOfClass( eBuilder )
	local numActiveBuilders = numActiveOfClass( s_playerIndex, eBuilder )
	
	-- are we current building a builder? don't build more then one at the same time
	if (numBuilders>numActiveBuilders) then
		ShipDemandAddByClass( eBuilder, -10 );
		return
	end
	
	-- don't build more then the specified number of builders in the following level of difficulty levels
	if (g_LOD == 0 and numBuilders > 3) then
		ShipDemandAddByClass( eBuilder, -10 );
		return
	elseif (g_LOD == 1 and numBuilders > 4) then
		ShipDemandAddByClass( eBuilder, -10 );
		return
	end
	
	-- no demand for builders until we have some military - and never build when underattack, even when we are winning
	if (s_militaryPop < 5 or (UnderAttack() == 1 and UnderAttackThreat() > -75) ) then
		ShipDemandAddByClass( eBuilder, -10 );
		return
	end
	
	local numRUs = GetRU()
	
	if (GetNumCollecting() < 7 and numRUs < 15000 ) then
		return
	end
	
	--aitrace("Builder Demand")
	
	local numRUToBuildTable = {
		1000,			--0 builders
		2000,			--1
		3500,		 	--2 (normal start)
		6500,			--3
		10000,		--4
		15000,		--5 or more
	}
	
	-- more than 5 is always the same
	if (numBuilders > 5) then
		numBuilders = 5
	end
		
	-- if we are hiigaran we need a bit more money to build another carrier/ shipyard
	local RUsNeededToBuildBuilder = numRUToBuildTable[numBuilders+1] -- values between 1-6
	if (s_race == Race_Vaygr) then
		RUsNeededToBuildBuilder = RUsNeededToBuildBuilder - 500
	end
	
	-- increase demand for carrier if we have lots of RUs sitting around or we have lots
	-- of collectors working away - which means more cash coming in (but we are not under 
	-- heavy attack) UnderAttackValue() < 50
	
	local dif = numRUs - RUsNeededToBuildBuilder
	--aitrace("Builder:numRUsNeed:"..dif)
	if (dif > 0) then
		-- add demand to the builders FOR NOW build a carrier if we can
		local ruPerShip =2000
		-- give a bigger bonus if we are winning
		if (s_militaryStrength > 30) then
			ruPerShip = 1000
		end
		
		local bonusDemand = (1+(dif/ruPerShip))
		ShipDemandAddByClass( eBuilder, bonusDemand ); -- should be based on amount of money
		
		--aitrace("Builder:Bonus:"..bonusDemand)
	end
	
	-- if we don't need builders for unitcap increase - and we already have lots of builders - decrease demand
	-- do this so we don't have a carrier/shipyard built randomly - it should always be a thought-out decision
	if (dif<-2000) then
		local penaltyDemand = dif/2000
		ShipDemandAddByClass( eBuilder, penaltyDemand );
		--aitrace("Builder:Pen:"..penaltyDemand)
	end

--~ 	-- should factor in current number of buildships somehow
--~ 	local threatLevel = UnderAttackThreat()+50
--~ 	-- if we are underattack and threatened - should increase need for military ships
--~ 	-- and decrease need for builder ships
--~ 	if (threatLevel > 0) then
--~ 		local threatPenalty = -threatLevel/25
--~ 		ShipDemandAddByClass( eBuilder,  threatPenalty);
--~ 		--aitrace("Builder:Thrt:"..threatPenalty)
--~ 	end
	
	-- connect number of military to number of carriers - 
	-- reduce demand for carriers when military value is low
	-- increase demand when its high AND we are winning and there is no threat
	local neededMilitaryValue = 30 + (numBuilders-1)*60
	--aitrace("Builder:MilNeed:"..neededMilitaryValue.." Have:"..s_selfTotalValue)
	local militaryDifDemand = (s_selfTotalValue - neededMilitaryValue)/30
	if (militaryDifDemand < 0) then
		ShipDemandAddByClass( eBuilder, militaryDifDemand );
		--aitrace("Builder:Mil:"..militaryDifDemand)
	
	--elseif (threatLevel <= -5 and s_militaryStrength > 100) then
	--	ShipDemandAddByClass( eBuilder, militaryDifDemand/2 );
	end
	
	
	return 0
	
end


