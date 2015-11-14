
aitrace("LOADING CPU RESEARCH")

function CpuResearch_Init()

	if (s_race == Race_Hiigaran) then
	
		dofilepath("data:ai/hiigaran_upgrades.lua")
		
		DoUpgradeDemand = DoUpgradeDemand_Hiigaran
		DoResearchTechDemand = DoResearchTechDemand_Hiigaran
	
	else
	
		dofilepath("data:ai/vaygr_upgrades.lua")
		
		DoUpgradeDemand = DoUpgradeDemand_Vaygr
		DoResearchTechDemand = DoResearchTechDemand_Vaygr
	
	end
	
	sg_lastUpgradeTime = gameTime()
	sg_upgradeDelayTime = 180 + Rand(80)
		
	-- this hook allows you to add randomness to the choosing of the best research
	cp_researchDemandRange = 0.5
	if (g_LOD == 1) then
		cp_researchDemandRange = 1
	end
	if (g_LOD == 0) then
		cp_researchDemandRange = 2
	end
	
	if (Override_ResearchInit) then
		Override_ResearchInit()
	end

end

function CpuResearch_DefaultResearchDemandRules()

	local threatlevel = UnderAttackThreat()
	-- if we are threatened
	if (threatlevel > 100) then
		return
	end
	
	-- add demand for each tech research - could add a global 'tech' demand bonus (a personality trait)
	DoResearchTechDemand()
	
	local curGameTime = gameTime()
	local timeSinceLastUpgrade = curGameTime - sg_lastUpgradeTime
	
	local economicValue = 0
	local numCollecting = GetNumCollecting();
	local numRU = GetRU()
	
	if ( (numRU > 2500 and numCollecting > 9) or numRU > 10000) then
		economicValue = 2
	elseif ( (numRU > 1500 and numCollecting > 7) or numRU > 6000) then
		economicValue = 1
	end
	
	-- upgrade every so often - every X seconds OR when we have excess amounts of money
	if (sg_doupgrades == 1 and threatlevel < -20 and s_militaryPop > 7 and economicValue > 0 and 
		(timeSinceLastUpgrade > sg_upgradeDelayTime or economicValue>1)) then
		
		-- add upgrade demand
		DoUpgradeDemand()
		sg_lastUpgradeTime = gameTime();
		
	end

end

function CpuResearch_Process()
	
	--aitrace("*CpuResearch_Process")
	
	-- if we are doing poorly economically or we are under quite a bit of threat then do not research
	if (GetNumCollecting() < sg_minNumCollectors and GetRU() < 2000) then
		return 0
	end
	
	-- if we have no research subsystems we can't research
	if (NumResearchSubSystems() == 0) then
		return 0
	end
	
	-- no need to continue processing research requests if the research system is full
	if (IsResearchBusy()==1) then
		return 0
	end

	-- must reset the reset demand every frame - then recaclulate it based on the current world state
	ResearchDemandClear()
	
	if (Override_ResearchDemand) then
		Override_ResearchDemand()
	else 
		CpuResearch_DefaultResearchDemandRules()
	end
	
	-- choose the research with the highest demand
	local bestResearch = FindHighDemandResearch()
		
	if ( bestResearch ~= 0) then
		Research( bestResearch )
		return 1
	end
	
	return 0
end

function DoResearchTechDemand_Vaygr()

		--
	-- NO RULES YET FOR
	--
	--REPAIRABILITY
	--SCOUTEMPABILITY
	
	if (Util_CheckResearch(HYPERSPACEGATETECH)) then
		local demand = ShipDemandGet(kShipYard)
		if (demand > 0) then
			ResearchDemandSet( HYPERSPACEGATETECH, demand+0.5 )
		end
	end
	
	
	
	-- battle cruiser ion weapons - required for battle cruiser to build - piggy backs its demand
	
	-- check to see if have any or if any shipyards are being built
	local numShipyards = NumSquadrons(kShipYard) + NumSquadronsQ(kShipYard)
	--local numHyperspaceSS = NumSubSystems(HYPERSPACE)+NumSubSystemsQ(HYPERSPACE)
	-- do battlecruiser research (only if we are in the process of getting hyperspace module)
	if (numShipyards > 0 and Util_CheckResearch(BATTLECRUISERIONWEAPONS)) then
		local battleCruiserDemand = ShipDemandGet( kBattleCruiser )
		if (battleCruiserDemand > 0) then
			ResearchDemandSet( BATTLECRUISERIONWEAPONS, battleCruiserDemand )
		end
	end
	
	-- do destroyer research (but only if we are getting cap ship module
	if (Util_CheckResearch(DESTROYERGUNS)) then
		local demand = ShipDemandGet(VGR_DESTROYER)
		if (demand > 0) then
			ResearchDemandSet( DESTROYERGUNS, demand )
		end
	end
	
	if (Util_CheckResearch(LANCEBEAMS)) then
		local lancedemand = ShipDemandGet(VGR_LANCEFIGHTER)
		if (lancedemand > 0) then
			ResearchDemandSet( LANCEBEAMS, lancedemand + 0.5 ) -- offset because its cheap
		end
	end
	
	
	if (Util_CheckResearch(PLASMABOMBS) ) then
		local bomberdemand = ShipDemandGet( VGR_BOMBER )
		if (bomberdemand > 0) then
			ResearchDemandSet( PLASMABOMBS, bomberdemand+1.0 ) -- offset because its cheap
		end
	end
	
	
	
	if (Util_CheckResearch(CORVETTELASER)) then
		local laserdemand = ShipDemandGet(VGR_LASERCORVETTE)
		if (laserdemand > 0) then
			ResearchDemandSet( CORVETTELASER, laserdemand )
		end
	end
	
	
	
	if (Util_CheckResearch(FRIGATEASSAULT)) then
		local demand = ShipDemandGet(VGR_ASSAULTFRIGATE)
		if (demand > 0) then
			ResearchDemandSet( FRIGATEASSAULT, demand )
		end
	end
	
	if (Util_CheckResearch(PLATFORMHEAVYMISSILES)) then
		local demand = ShipDemandGet(VGR_WEAPONPLATFORM_MISSILE)
		if (demand > 0) then
			ResearchDemandSet( PLATFORMHEAVYMISSILES, demand )
		end
	end
	
	if (Util_CheckResearch(BOMBERIMPROVEDBOMBS) ) then
		local numBombers = NumSquadrons( kBomber )
		if (numBombers > 2) then
			ResearchDemandSet( BOMBERIMPROVEDBOMBS, numBombers )
		end
	end
	
	if (Util_CheckResearch(CORVETTETECH) ) then
		local corvdemand = ShipDemandMaxByClass( eCorvette )
		if (corvdemand > 0) then
			ResearchDemandSet( CORVETTETECH, corvdemand+0.5 )
		end
	end
	
	if (Util_CheckResearch(FRIGATETECH) ) then
		local frigdemand = ShipDemandMaxByClass( eFrigate )
		if (frigdemand > 0) then
			ResearchDemandSet( FRIGATETECH, frigdemand+0.5 )
		end
	end
	
	if (s_militaryPop > 15 and GetRU() > 750) then
	
		if (Util_CheckResearch(CORVETTEGRAVITICATTRACTION) ) then
			local mineLayerDemand = ShipDemandGet(VGR_MINELAYERCORVETTE)
			if (mineLayerDemand > 0) then
				ResearchDemandSet( CORVETTEGRAVITICATTRACTION, mineLayerDemand )
			end
		end
		
		if (Util_CheckResearch(CORVETTECOMMAND)) then
			local commanddemand = ShipDemandGet(VGR_COMMANDCORVETTE)
			if (commanddemand > 0) then
				ResearchDemandSet( CORVETTECOMMAND, commanddemand )
			end
		end
		
		if (Util_CheckResearch(FRIGATEINFILTRATIONTECH)) then
			local demand = ShipDemandGet(VGR_INFILTRATORFRIGATE)
			if (demand > 0) then
				ResearchDemandSet( FRIGATEINFILTRATIONTECH, demand )
			end
		end
	
	end
		
end

-- check to see if research is not done but currently available
function Util_CheckResearch( researchId )
	if (IsResearchDone(researchId) == 0 and 
	    IsResearchAvailable(researchId)==1) then
		return 1
	end
	return nil
end

function DoResearchTechDemand_Hiigaran()

	-- NO RULES YET FOR
	--
	--REPAIRABILITY
	--SCOUTEMPABILITY
	--SCOUTPINGABILITY

	local numShipyards = NumSquadrons(kShipYard) + NumSquadronsQ(kShipYard)
	-- battle cruiser ion weapons - required for battle cruiser to build - piggy backs its demand
	if (numShipyards > 0 and Util_CheckResearch(BATTLECRUISERIONWEAPONS)) then
		local battleCruiserDemand = ShipDemandGet( kBattleCruiser )
		if (battleCruiserDemand > 0) then
			ResearchDemandSet( BATTLECRUISERIONWEAPONS, battleCruiserDemand )
		end
	end
	
	-- ionturret - needed to build ion turrets so use the same demand value
	if (Util_CheckResearch(PLATFORMIONWEAPONS)) then
		local ionTurretDemand = ShipDemandGet(HGN_IONTURRET)
		if (ionTurretDemand > 0) then
			ResearchDemandSet( PLATFORMIONWEAPONS, ionTurretDemand )
		end
	end
	
	if (Util_CheckResearch(DESTROYERTECH) ) then
		-- get the demand for destroyer
		local destroyerDemand = ShipDemandGet(HGN_DESTROYER)
		if (destroyerDemand > 0) then
			ResearchDemandSet( DESTROYERTECH, destroyerDemand )
		end
	end
	
	if (Util_CheckResearch(ATTACKBOMBERIMPROVEDBOMBS) ) then
		local numBombers = NumSquadrons( kBomber )
		if (numBombers > 2) then
			ResearchDemandSet( ATTACKBOMBERIMPROVEDBOMBS, numBombers )
		end
	end
	
	if (Util_CheckResearch(IMPROVEDTORPEDO) ) then
		local numTorpedoFrigs = NumSquadrons( HGN_TORPEDOFRIGATE )
		if (numTorpedoFrigs > 2) then
			ResearchDemandSet( IMPROVEDTORPEDO, numTorpedoFrigs )
		end
	end
	
	if (s_militaryPop > 15 and GetRU() > 750) then
		
		if (Util_CheckResearch(DEFENSEFIELDFRIGATESHIELD) ) then
			local DFFDemand = ShipDemandGet(HGN_DEFENSEFIELDFRIGATE)
			if (DFFDemand > 0) then
				ResearchDemandSet( DEFENSEFIELDFRIGATESHIELD, DFFDemand )
			end
		end
		
		if (Util_CheckResearch(ECMPROBE) ) then
			local ecmProbeDemand = ShipDemandGet(HGN_ECMPROBE)
			if (ecmProbeDemand>0) then
				ResearchDemandSet( ECMPROBE, ecmProbeDemand )
			end
		end
			
		if (Util_CheckResearch(GRAVITICATTRACTIONMINES) ) then
			local mineLayerDemand = ShipDemandGet(HGN_MINELAYERCORVETTE)
			if (mineLayerDemand > 0) then
				ResearchDemandSet( GRAVITICATTRACTIONMINES, mineLayerDemand )
			end
		end
		
	end


end

function DoUpgradeDemand_Hiigaran()
	
	-- based on the actual count of each ship determine which upgrades to do
	
	-- make sure we are winning before doing some of these upgrades
	if (s_militaryStrength > 10 or g_LOD == 0) then
		
		-- mothership upgrades
		
		-- if underattack (or some random factor - need more intel here)
		inc_upgrade_demand( rt_mothership, 0.5  )
		
		-- also demand for build speed upgrade on the MS
		ResearchDemandAdd( MOTHERSHIPBUILDSPEEDUPGRADE1, 0.5 )
		
		-- hyperspace upgrades - what prereqs ? num carriers, 
		--inc_upgrade_demand( rt_hyperspace, 0.5  )
		
		-- do platforms
		local numPlatforms = numActiveOfClass( s_playerIndex, ePlatform )
		if (numPlatforms > 1) then
			local numGunTurret = NumSquadrons( HGN_GUNTURRET )
			if (numGunTurret > 1) then
				inc_upgrade_demand( rt_platform.gunturret, numGunTurret*1 )
			end
			local numIonTurret = NumSquadrons( HGN_IONTURRET )
			if (numIonTurret > 1) then
				inc_upgrade_demand( rt_platform.ionturret, numIonTurret*1 )
			end
		end
		
		-- collectors are always around - good to upgrades these (unless playtesters tell us otherwise)
		local numCollectors = NumSquadrons( kCollector )
		if (numCollectors > 0) then
			inc_upgrade_demand( rt_collector, numCollectors*.1 )
		end
		
		local numRefinery = NumSquadrons( kRefinery )
		if (numRefinery > 0) then
			inc_upgrade_demand( rt_refinery, numRefinery*1.5 )
		end
		
		-- carrier
		local numCarrier = NumSquadrons( kCarrier )
		if (numCarrier > 0) then
			inc_upgrade_demand( rt_carrier, numCarrier*1 )
			ResearchDemandAdd( CARRIERBUILDSPEEDUPGRADE1, numCarrier*1.25 )
		end
		
		-- shipyard
		local numShipYards = NumSquadrons( kShipYard )
		if (numShipYards > 0) then
			inc_upgrade_demand( rt_shipyard, numShipYards*1.5  )
			ResearchDemandAdd( SHIPYARDBUILDSPEEDUPGRADE1, numShipYards*1.75 )
		end
	end
	
	-- do fighter upgrades
	local numFighter = numActiveOfClass( s_playerIndex, eFighter )
	if (numFighter > 1) then
		-- interceptors
		local numInterceptors = NumSquadrons( kInterceptor )
		if (numInterceptors > 1) then
			inc_upgrade_demand( rt_fighter.interceptor, numInterceptors*1 )
		end
		-- bombers
		local numBombers = NumSquadrons( kBomber )
		if (numBombers > 1) then
			inc_upgrade_demand( rt_fighter.bomber, numBombers*1.5 )
		end
	end
	
	-- battlecruiser upgrades
	local numBattleCruiser = NumSquadrons( kBattleCruiser )
	if (numBattleCruiser > 0) then
		inc_upgrade_demand( rt_battlecruiser, numBattleCruiser*2.5  )
	end
	
	-- destroyer upgrades
	local numDestroyers = NumSquadrons( kDestroyer )
	if (numDestroyers > 0) then
		inc_upgrade_demand( rt_destroyer, numDestroyers*2  )
	end
	
	-- do corvette upgrades
	local numCorvette = numActiveOfClass( s_playerIndex, eCorvette )
	if (numCorvette > 1) then
		local numAssaultCorvette = NumSquadrons( HGN_ASSAULTCORVETTE )
		if (numAssaultCorvette>2) then
			inc_upgrade_demand( rt_corvette.assault, numAssaultCorvette*1.25 )
		end
		local numPulsarCorvette = NumSquadrons( HGN_PULSARCORVETTE )
		if (numPulsarCorvette>2) then
			inc_upgrade_demand( rt_corvette.pulsar, numPulsarCorvette*1.25 )
		end
	end
	
	-- do frigate upgrades
	local numFrigate = numActiveOfClass( s_playerIndex, eFrigate )
	if (numFrigate > 2) then
		local numTorpedoFrigate = NumSquadrons( HGN_TORPEDOFRIGATE )
		if (numTorpedoFrigate>2) then
			inc_upgrade_demand( rt_frigate.torpedo, numTorpedoFrigate*1.5 )
		end
		local numIonFrigate = NumSquadrons( HGN_IONCANNONFRIGATE )
		if (numIonFrigate>2) then
			inc_upgrade_demand( rt_frigate.ioncannon, numIonFrigate*1.5 )
		end
		local numAssaultFrigate = NumSquadrons( HGN_ASSAULTFRIGATE )
		if (numAssaultFrigate>2) then
			inc_upgrade_demand( rt_frigate.assault, numAssaultFrigate*1.5 )
		end
	end
	
	
	
end

function DoUpgradeDemand_Vaygr()
	
	-- based on the actual count of each ship determine which upgrades to do
	
	if (s_militaryStrength > 10 or g_LOD == 0) then
	
		-- mothership upgrades
		-- if underattack (or some random factor - need more intel here)
		inc_upgrade_demand( rt_mothership, 0.5 )
		
		-- also demand for build speed upgrade on the MS
		ResearchDemandAdd( MOTHERSHIPBUILDSPEEDUPGRADE1, 0.5 )
		
		-- do corvette upgrades
		local numCorvette = numActiveOfClass( s_playerIndex, eCorvette )
		if (numCorvette > 2) then
			inc_upgrade_demand( rt_corvette, numCorvette )
		end
		
		-- do frigate upgrades
		local numFrigate = numActiveOfClass( s_playerIndex, eFrigate )
		if (numFrigate > 2) then
			inc_upgrade_demand( rt_frigate, numFrigate*1 )
		end
		
		-- do platforms
		local numPlatforms = numActiveOfClass( s_playerIndex, ePlatform )
		if (numPlatforms > 0) then
			inc_upgrade_demand( rt_platform, numPlatforms*1 )
		end
		
		local numCapital = numActiveOfClass( s_playerIndex, eCapital )
		if (numCapital > 1) then
			inc_upgrade_demand( rt_capital, numCapital*0.5 )
		end
		
		-- carrier
		local numCarrier = NumSquadrons( kCarrier )
		if (numCarrier > 0) then
			ResearchDemandAdd( CARRIERBUILDSPEEDUPGRADE1, numCarrier*1.25 )
		end
		
		-- shipyard
		local numShipYards = NumSquadrons( kShipYard )
		if (numShipYards > 0) then
			ResearchDemandAdd( SHIPYARDBUILDSPEEDUPGRADE1, numShipYards*1.75 )
		end
	end
	
end

-- RESEARCH HELPER FUNCTIONS

-- could move this to code if its too slow
function inc_research_demand( researchtype, val)

	local typeis = typeid(researchtype);
	
	-- recursive function that 
	if (typeis == LT_TABLE) then
		for i, v in researchtype do
			inc_research_demand(v, val);
		end
	else
		if (Util_CheckResearch(researchtype)) then
			ResearchDemandAdd( researchtype, val )
		end
	end
end

function inc_upgrade_demand( upgradetype, val )
	inc_research_demand( upgradetype, val )
end


