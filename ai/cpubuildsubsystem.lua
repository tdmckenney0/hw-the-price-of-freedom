

function CpuBuildSS_Init()

	if (s_race == Race_Hiigaran) then
		-- set this function to point to the hiigaran version of this function
		CpuBuildSS_DefaultSubSystemDemandRules = DoSubSystemDemand_Hiigaran
	else
		-- set this function to point to the vaygr version of this function
		CpuBuildSS_DefaultSubSystemDemandRules = DoSubSystemDemand_Vaygr
	end
	
	sg_lastSpecialSubSysTime = 0
	sg_specialSubSysDelayTime = 150 + Rand(100)

	-- this is used internally to count the number of times a vaygr carrier wants to retire a subsystem
	-- we do this prevent blips in the thought process where in one frame the AI loses huge ship demand
	sg_retireCountCheck = 0
	
	-- should AI build hyperspace on battlecruisers
	sg_buildBCHyperspace = 1
	
end


-- handle subsystem demand for the 'other' subsystems - not production or research
function CpuBuildSS_SpecialSubSystemDemand()
	
	local curGameTime = gameTime()
	local timeSinceLastSubSysDemand = curGameTime - sg_lastSpecialSubSysTime
		
	-- demand calculation for system modules, only do this if not under attack
	if(s_selfTotalValue > 160 and s_militaryStrength > -5 and UnderAttackThreat() < -70 and (timeSinceLastSubSysDemand > sg_specialSubSysDelayTime or GetRU() > 3000)) then
	
		-- count up the total demand for production modules
		local productionDemand = SubSystemDemandGet(FIGHTERPRODUCTION) +
					 SubSystemDemandGet(CORVETTEPRODUCTION) +
					 SubSystemDemandGet(FRIGATEPRODUCTION) +
					 SubSystemDemandGet(CAPSHIPPRODUCTION) +
					 SubSystemDemandGet(PLATFORMPRODUCTION) +
					 SubSystemDemandGet(RESEARCH) +
					 SubSystemDemandGet(ADVANCEDRESEARCH)

		aitrace("SS:special demand:"..productionDemand)
					 
		if(productionDemand <= 1.0) then
			-- very little demand for production, we can look at system modules
			-- set demand for all of the special subsystems
			local specialSubsystems = {HYPERSPACE,FIRECONTROLTOWER,HYPERSPACEINHIBITOR}
			if (g_LOD < 2) then
				specialSubsystems = {HYPERSPACE,CLOAKGENERATOR,FIRECONTROLTOWER,HYPERSPACEINHIBITOR,ADVANCEDARRAY,CLOAKSENSOR,PlanetSmasher}
			end
			-- do this based on the numbers already built, want a roughly even number of all of these?
			local minNumber = 10
			local maxNumber = 0
			for a,b in specialSubsystems do
				local numberBuilt = NumSubSystems(b) + NumSubSystemsQ(b)
				if(numberBuilt < minNumber) then
				    minNumber = numberBuilt
				end
				if(numberBuilt > maxNumber) then
				    maxNumber = numberBuilt
				end
			end
			-- now we've got a min and max we can scale demand
			for a,b in specialSubsystems do
				
				local numQueued = NumSubSystemsQ(b)
				
				if (numQueued == 0) then
					local numberBuilt = NumSubSystems(b) + numQueued 
					local demand = 1.0
					if(minNumber < maxNumber) then
						demand = demand * (1.0 - ((numberBuilt - minNumber) / (maxNumber - minNumber)))
					end
					
					SubSystemDemandAdd(b,demand)
				end
				
			end
			
			-- update the time
			sg_lastSpecialSubSysTime = curGameTime;
		end
	end
end

function CpuBuildSS_RetireVaygrProductionSubSystems()

	local numCarriers = CarrierCount()
	for i=0, (numCarriers-1) do
	
		local carrier = CarrierAt( i )
		
		local productionId = CarrierProductionSubSystem( carrier )
		
		if (productionId ~= 0) then
			local ssdemand = SubSystemDemandGet( productionId )
--~ 			local count = NumSubSystems(productionId) + NumSubSystemsQ( productionId )
--~ 			if (count > 1) then
--~ 				ssdemand = ssdemand - 0.5
--~ 			end
			
			-- if the demand for this subsystem is low and we already have one of these
			-- elsewhere then get rid of it
			if (ssdemand < 0) then
				sg_retireCountCheck = sg_retireCountCheck + 1
				if (sg_retireCountCheck >= 2) then
				
					aitrace("VaygrCarrierRetire: Dem:"..ssdemand.." Count:"..sg_retireCountCheck )
					-- retire this subsystem
					RetireSubSystem( carrier, productionId )
					-- should replace with something right here
					sg_retireCountCheck = 0
					return
				end
			else
				sg_retireCountCheck = 0
			end
			
		end
	
	end

end

function std_minTuple(a, b, c )

	local minsubs = a
	if (b < minsubs) then
		minsubs = b
	end
	if (c < minsubs) then
		minsubs = c
	end
	
	return minsubs

end

function std_maxTuple(a, b, c )

	local maxsubs = a
	if (b > maxsubs) then
		maxsubs = b
	end
	if (c > maxsubs) then
		maxsubs = c
	end
	
	return maxsubs

end

function CpuBuildSS_ProcessEachBuildShip()

	--aitrace("****CpuBuildSS_ProcessEachBuildShip")
	
	-- number of build ships
	local bcount = BuildShipCount()
	
	-- this would be VERY bad
	if (bcount == 0) then
		return 0
	end
		
	-- if there is no production subsystems yet - no need for this stuff either
	if (s_totalProdSS == 0) then
		return 0
	end
	
	--aitrace("**SubSystemDemand**")
	aitrace("NumSS:Fi:"..s_numFiSystems.." Co:"..s_numCoSystems.." Fr:"..s_numFrSystems)
	
	-- get the demand for each production subsystem
	local currentFiDemand = SubSystemDemandGet(FIGHTERPRODUCTION)
	local currentCoDemand = SubSystemDemandGet(CORVETTEPRODUCTION)
	local currentFrDemand = SubSystemDemandGet(FRIGATEPRODUCTION)
	
	-- get the max value for the real demand on each of these subsystems
	local maxRealDemand  = std_maxTuple(currentFiDemand, currentCoDemand, currentFrDemand )
	
	-- get the highest priority subsystem overall
	local highestPrioritySSOverall = HighestPrioritySubSystem()
			
	aitrace("SS:Fi:"..currentFiDemand.." Co:"..currentCoDemand.." Fr:"..currentFrDemand)
	
	
	-- if some other subsystem - not a production subsystem has a higher demand then 
	-- no need to do the following
--~ 	if (highestPrioritySSOverall > maxRealDemand or maxRealDemand < 0) then
--~ 		return 0
--~ 	end
	
	-- what is the least of these three subsystems
	local minNumSameSubs = std_minTuple(s_numFiSystems, s_numCoSystems, s_numFrSystems)
	
	-- determine the demand offset of each subsystem based on how many this AI has in total
	local fiBuildOffset =  ((s_numFiSystems-minNumSameSubs)/bcount)*3 --was 4
	local coBuildOffset = ((s_numCoSystems-minNumSameSubs)/bcount)*3
	local frBuildOffset =  ((s_numFrSystems-minNumSameSubs)/bcount)*3
	
	-- determine the production subsystem with the highest demand
	local bestProdSS = FIGHTERPRODUCTION
	local maxDemand = currentFiDemand - fiBuildOffset
	
	aitrace("Maxdemand:"..maxDemand.."MaxReal:"..maxRealDemand)
	
	if ((currentCoDemand-coBuildOffset) > maxDemand) then
		maxDemand = currentCoDemand - coBuildOffset
		bestProdSS = CORVETTEPRODUCTION
		--aitrace("corv better")
	end
	if ((currentFrDemand-frBuildOffset) > maxDemand) then
		maxDemand = currentFrDemand - frBuildOffset
		bestProdSS = FRIGATEPRODUCTION
		--aitrace("frig better")
	end
	
	-- determine economic value for this player
	local economicValue = 0
	local numCollecting = GetNumCollecting();
	local numRU = GetRU()
	
	-- these are these are checks to see if we should build an extra subsystem on a ship even if we don't need it right now
	if (UnderAttack()==0 or UnderAttackThreat() < -100) then
	
		if ( (numRU > (2500+bcount*1000) and numCollecting > 8) ) then
			economicValue = 2
		elseif ( (numRU > (1000+bcount*500) and numCollecting > 6) ) then
			economicValue = 1
		end
		
	end
		
	------
	
	for i=0, (bcount-1) do
	
		local buildShipId = BuildShipAt( i )
		
		-- special case for battlecruiser
		if (sg_buildBCHyperspace == 1 and BuildShipType( buildShipId ) == kBattleCruiser) then
			aitrace("BC:SS")
			if (BuildShipHasSubSystem( buildShipId, HYPERSPACE ) == 0 and UnderAttackThreat() < -5 and
			    BuildShipCanBuild( buildShipId, HYPERSPACE) == 1) then
					aitrace("Build BC Hyperspace")
					BuildSubSystemOnShip( buildShipId, HYPERSPACE )
					return 1
			end
		end
		
		-- only do this if the highest ss demand is less than or equal to the demand for a production ss AND
		-- the demand is greater then zero
		-- This means if there is demand for something else out there then do that first - don't deal with production slots
		if (highestPrioritySSOverall <= maxRealDemand and maxRealDemand >= 0) then
		
			-- does this ship have any production subsystems, if so which ones
			local hasFi = BuildShipHasSubSystem( buildShipId, FIGHTERPRODUCTION )
			local hasCo = BuildShipHasSubSystem( buildShipId, CORVETTEPRODUCTION )
			local hasFr = BuildShipHasSubSystem( buildShipId, FRIGATEPRODUCTION )
			local sscount = hasFi + hasCo + hasFr
			
			local allowBuild = 0
			if (sscount > 0) then
			
				-- if we have on subsystem and we have a good economy allow another SS to be built on this ship if desired
				if (sscount == 1 and economicValue > 0) then
					allowBuild = 1
					aitrace("Scount"..sscount.." Econ:"..economicValue)
				elseif (sscount == 2 and economicValue > 1) then
					allowBuild = 1
					aitrace("Scount"..sscount.." Econ:"..economicValue)
				else
					local maxDemandOnShip = -1
					if (hasFi == 1 and currentFiDemand > maxDemandOnShip) then
						maxDemandOnShip = currentFiDemand
					end
					if (hasCo == 1 and currentCoDemand > maxDemandOnShip) then
						maxDemandOnShip = currentCoDemand
					end
					if (hasFr == 1 and currentFrDemand > maxDemandOnShip) then
						maxDemandOnShip = currentFrDemand
					end
					-- if this ship has no production subs to build anything then
					if (maxDemandOnShip < 0) then
						allowBuild = 1
					end
					-- if we are underattack and the bestdemand > maxDemand on this ship
					--if (UnderAttackThreat() > (sscount-1)*100 and maxDemandOnShip)
					aitrace("S"..i.." FiD:"..currentFiDemand.." CoD:"..currentCoDemand.." FrD:"..currentFrDemand)
					aitrace("S"..i.." Max:"..maxDemandOnShip)
				end
			else
				allowBuild = 1
			end
			
			-- if this ship has no production subs to build anything then
			if (allowBuild == 1) then
				-- build the production SS with the highest demand
				if (BuildShipCanBuild( buildShipId, bestProdSS) == 1) then
					aitrace("BuildSS in new func")
					BuildSubSystemOnShip( buildShipId, bestProdSS )
					return 1
				end
			end
		end
		
	end
	
	-- set these to -1 to prevent these production systems to be build outside of this function
	SubSystemDemandSet( FIGHTERPRODUCTION, -1)
	SubSystemDemandSet( CORVETTEPRODUCTION, -1)
	SubSystemDemandSet( FRIGATEPRODUCTION, -1)
	
	return 0

end

function CpuBuildSS_DoBuildSubSystem()

	--aitrace("***CpuBuildSS_DoBuildSubSystem")
	
	-- 
	SubSystemDemandClear()
	
	if (Override_SubSystemDemand) then
		Override_SubSystemDemand()
	else
		CpuBuildSS_DefaultSubSystemDemandRules()
	end
			
	-- do subsystem (improvement)
	local subSystemId = FindHighDemandSubSystem()
	
	-- reset overflow demand for subsystems if we get here (so we can build a ship next time around)
	sg_subSystemOverflowDemand = 0
	
	-- check to see if we should retire any subsystems to be replaced by others
	if (s_race == Race_Vaygr) then
		CpuBuildSS_RetireVaygrProductionSubSystems()
	end
	
	if (subSystemId > 0) then
	
		-- run through each build ship and determine if we should build any production subsystem
		-- do this seperately from the other subsystems
		if (CpuBuildSS_ProcessEachBuildShip() == 1) then
			return 1
		end
	
		-- redo the calculation in case the processEach function modified some values
		subSystemId = FindHighDemandSubSystem()
	
		-- check again to make sure the subsystem id is still valid - since it may have been reduced
		if (subSystemId > 0) then
			-- build the selected subsystem
			BuildSubSystem( subSystemId )
		end
		
		return 1
	end

	return 0
	
end

-- helper function for setting the demand for production subsystems
function CpuBuildSS_DoSubSystemProductionDemand( ProductionSubSys, eClasstype, familyid )

	-- determine FIGHTERPRODUCTION demand
	local demand = ShipDemandMaxByClass( eClasstype )
	
	local uc = GetUnitCapForFamily(familyid)
	local ucMax = GetUnitCapMaxForFamily(familyid)
	
	local ucLeft = ucMax - uc
	
	if (ucLeft < 2) then
		demand = demand - 3 + ucLeft
	end
	
	-- cap the low value - the subsystem builder needs to know if this subsys is bad (negative) or good
	if (demand < 0) then
		demand = -0.5
	end
	
	SubSystemDemandSet(ProductionSubSys, demand )

end

function CpuBuildSS_OtherMiscSubSystemDemand()

	-- determine demand for capship production
	local demand = ShipDemandMaxByClass( eBuilder )
	local capdemand = ShipDemandMaxByClass( eCapital )
	if (capdemand > demand) then
		demand = capdemand
	end
	
	-- CAPSHIP demand
	if (demand > 0.5) then
		SubSystemDemandSet(CAPSHIPPRODUCTION, demand-0.5 )
	end
	
	-- determine demand for PLATFORMPRODUCTION
	if (s_militaryStrength < -50 or g_LOD < 1 or GetRU() > 4000) then
		local platformsubsCount = NumSubSystems(PLATFORMPRODUCTION) + NumSubSystemsQ(PLATFORMPRODUCTION)
		demand = ShipDemandMaxByClass( ePlatform )
		if (demand > 0.5) then
			SubSystemDemandSet(PLATFORMPRODUCTION, demand-1-platformsubsCount )
		end
	end
	
	-- if we have no shipyards try to get hyperspace module to build one - if we have one - no need for the demand
	local numShipyards = NumSquadrons(kShipYard)
	if ( numShipyards == 0 ) then
		local SY_demand = ShipDemandGet(kShipYard)
		-- demand for hyperspace is determine by the demand for shipyards - also check to make sure we are 
		-- only asking for 1 hyperspace module at a time
		if (SY_demand > 0 and NumSubSystemsQ(HYPERSPACE) == 0) then
			local hypDemand = SY_demand - 0.5 - NumSubSystems(HYPERSPACE)
			SubSystemDemandAdd(HYPERSPACE, hypDemand )
		end
	end
		
end

function DoSubSystemDemand_Hiigaran()

	-- based on the highest demand determine what subsystems to ask for
	-- if fighter demand is high then request that
	-- if corvette and frigate demand is high then research modules
	-- if carrier/builders then capital ship

	-- determine FIGHTERPRODUCTION demand
	CpuBuildSS_DoSubSystemProductionDemand( FIGHTERPRODUCTION, eFighter, kUnitCapId_Fighter )
	
	-- Demand for RESEARCH
	local researchcount = NumSubSystems(RESEARCH) + NumSubSystemsQ(RESEARCH)
	
	local highestCorvetteDemand = ShipDemandMaxByClass( eCorvette )
	local highestFrigateDemand = ShipDemandMaxByClass( eFrigate )
	
	-- determine demand for research - accumalating demand for high-level ships
	local researchdemand = highestCorvetteDemand
	local capdemand = ShipDemandMaxByClass( eCapital )
	if (highestFrigateDemand > researchdemand) then
		researchdemand = highestFrigateDemand
	elseif (capdemand > researchdemand) then
		researchdemand = capdemand
	end
	
	-- always need some research (+0.5 to demand) - if its destroyed we should check to see if we have subs for building ships
	if (researchcount==0) then
		-- demand is equivalent to all things its opens (corvette and frigate and capital)
		SubSystemDemandSet(RESEARCH, researchdemand+0.5 )
	else
		
		-- determine CORVETTEPRODUCTION demand
		CpuBuildSS_DoSubSystemProductionDemand( CORVETTEPRODUCTION, eCorvette, kUnitCapId_Corvette )
		-- determine FRIGATEPRODUCTION demand
		CpuBuildSS_DoSubSystemProductionDemand( FRIGATEPRODUCTION, eFrigate, kUnitCapId_Frigate )
		
		-- the more Frigate subs the more we need advanced research
		-- other factors: underattack, strength, militarypop, economy
		local advresearchcount = NumSubSystems(ADVANCEDRESEARCH) + NumSubSystemsQ(ADVANCEDRESEARCH)
		local doAdvResearch = 0
		local advResDemand = researchdemand
		-- if we already have a frigate subsystem then put demand up by a half point to increase odds of building
		if (s_numFrSystems > 0) then
			researchdemand = researchdemand + 0.5
		end
		if (advresearchcount == 0 and researchdemand >= 0.5 and UnderAttackThreat() < -5 and
			(s_militaryPop > 8 or s_selfTotalValue > 150 or s_militaryStrength > 50) ) then

			SubSystemDemandSet(ADVANCEDRESEARCH, researchdemand-0.5 )
			
		end

		-- if we already have a fighter system and no corvette or frigate but we can build them - reduce demand for fighter subsys
	
	end
	
	-- demand for carrierprod, platform, hyperspace, ...
	CpuBuildSS_OtherMiscSubSystemDemand();
	
	-- before doing the 'extra' subsystems make sure we have a research SS and production SS and a few military dudes
	if (researchcount > 0 and s_totalProdSS > 0 and s_militaryPop > 8 and GetNumCollecting() > 8 and GetRU() > 800) then
		CpuBuildSS_SpecialSubSystemDemand()
	end

end

function DoSubSystemDemand_Vaygr()

	-- based on the highest demand determine what subsystems to ask for
	-- if fighter demand is high then request that
	-- if corvette and frigate demand is high then research modules
	-- if carrier/builders then capital ship

	-- determine FIGHTERPRODUCTION demand
	CpuBuildSS_DoSubSystemProductionDemand( FIGHTERPRODUCTION, eFighter, kUnitCapId_Fighter )
	
	-- Demand for RESEARCH
	local researchcount = NumSubSystems(RESEARCH) + NumSubSystemsQ(RESEARCH)
	
	-- cache the demand for these two classes
	local highestCorvetteDemand = ShipDemandMaxByClass( eCorvette )
	local highestFrigateDemand = ShipDemandMaxByClass( eFrigate )
	local capdemand = ShipDemandMaxByClass( eCapital )
	
	-- if we do not have the research subsystem - check to see if want it - I'd imagine it would always be YES
	if (researchcount==0) then
		
		-- determine demand for research - accumalating demand for high-level ships
		local researchdemand = highestCorvetteDemand
		
		if (highestFrigateDemand > researchdemand) then
			researchdemand = highestFrigateDemand
		elseif (capdemand > researchdemand) then
			researchdemand = capdemand
		end
		
		-- demand is equivalent to all things its opens (corvette and frigate and capital)
		SubSystemDemandSet(RESEARCH, researchdemand+1 )
	end
	
	-- check to see if we have corvette tech
	if (IsResearchDone(CORVETTETECH) == 1) then
		
		CpuBuildSS_DoSubSystemProductionDemand( CORVETTEPRODUCTION, eCorvette, kUnitCapId_Corvette )
		
	end
	
	if (IsResearchDone(FRIGATETECH) == 1) then
	
		CpuBuildSS_DoSubSystemProductionDemand( FRIGATEPRODUCTION, eFrigate, kUnitCapId_Frigate )
	
	end
	
	-- demand for carrierprod, platform, hyperspace, ...
	CpuBuildSS_OtherMiscSubSystemDemand();
	
	-- before doing the 'extra' subsystems make sure we have a research SS and production SS and a few military dudes
	if (researchcount > 0 and s_totalProdSS > 0 and s_militaryPop > 8 and GetNumCollecting() > 8 and GetRU() > 800) then
		CpuBuildSS_SpecialSubSystemDemand()
	end

end