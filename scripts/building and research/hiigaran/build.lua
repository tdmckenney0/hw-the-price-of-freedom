-- Cold Fusion LUA Decompiler v1.0.0
-- By 4E534B
-- Date: 08-15-2021 Time: 20:22:29
-- On error(s), send source (compiled) file to 4E534B@gmail.com

Ship = 0
SubSystem = 1
build = {
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Production_Fighter",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7000",
        Description = "$7001"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Production_Fighter",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7000",
        Description = "$7001"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Production_Corvette",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7002",
        Description = "$7003"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Production_Corvette",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7002",
        Description = "$7003"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Production_Frigate",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7004",
        Description = "$7005"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Production_Frigate",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7004",
        Description = "$7005"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Production_CapShip",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7006",
        Description = "$7007"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_SY_Production_CapShip",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7006",
        Description = "$7007"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_PlatformControl",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 10,
        DisplayedName = "$7008",
        Description = "$7009"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_PlatformControl",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 20,
        DisplayedName = "$7008",
        Description = "$7009"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_Hyperspace",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 30,
        DisplayedName = "$7014",
        Description = "$7015"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_Hyperspace",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 30,
        DisplayedName = "$7014",
        Description = "$7015"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_HyperspaceInhibitor",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 40,
        DisplayedName = "$7016",
        Description = "$7017"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_HyperspaceInhibitor",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 40,
        DisplayedName = "$7016",
        Description = "$7017"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_CloakGenerator",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 50,
        DisplayedName = "$7018",
        Description = "$7019"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_CloakGenerator",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 50,
        DisplayedName = "$7018",
        Description = "$7019"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_FireControl",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_FireControl",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
	{
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_Build",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_Build",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
	{
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_FusionCell",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Module_FusionCell",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
	-- The "Repair" modules doesn't have an larger module just yet.
	{
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Module_Repair",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 60,
        DisplayedName = "$7020",
        Description = "$7021"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Sensors_DetectHyperspace",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 150,
        DisplayedName = "$7036",
        Description = "$7037"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Sensors_DetectHyperspace",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 150,
        DisplayedName = "$7036",
        Description = "$7037"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Sensors_AdvancedArray",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 151,
        DisplayedName = "$7022",
        Description = "$7023"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Sensors_AdvancedArray",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 151,
        DisplayedName = "$7022",
        Description = "$7023"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_C_Sensors_DetectCloaked",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 152,
        DisplayedName = "$7024",
        Description = "$7025"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Sensors_DetectCloaked",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 152,
        DisplayedName = "$7024",
        Description = "$7025"
    },
    {
        Type = Ship,
        ThingToBuild = "Kpr_Mover",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 53,
        DisplayedName = "$7913",
        Description = "$7914"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Hgn_MS_Production_CorvetteMover",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 10,
        DisplayedName = "$7910",
        Description = "$7911"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Scout",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 10,
        DisplayedName = "$7030",
        Description = "$7031"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Interceptor",
        RequiredResearch = "",
        RequiredShipSubSystems = "FighterProduction",
        DisplayPriority = 20,
        DisplayedName = "$7032",
        Description = "$7033"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_AttackBomber",
        RequiredResearch = "",
        RequiredShipSubSystems = "FighterProduction",
        DisplayPriority = 30,
        DisplayedName = "$7034",
        Description = "$7035"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_AssaultCorvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 50,
        DisplayedName = "$7038",
        Description = "$7039"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_PulsarCorvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 51,
        DisplayedName = "$7040",
        Description = "$7041"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_MinelayerCorvette",
        RequiredResearch = "GraviticAttractionMines",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 52,
        DisplayedName = "$7042",
        Description = "$7043"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_DefenseFieldFrigate",
        RequiredResearch = "DefenseFieldFrigateShield",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 80,
        DisplayedName = "$7044",
        Description = "$7045"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_TorpedoFrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 60,
        DisplayedName = "$7046",
        Description = "$7047"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_AssaultFrigate",
        RequiredResearch = "InstaAdvancedFrigateTech",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 65,
        DisplayedName = "$7048",
        Description = "$7049"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_IonCannonFrigate",
        RequiredResearch = "InstaAdvancedFrigateTech",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 70,
        DisplayedName = "$7050",
        Description = "$7051"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_MarineFrigate",
        RequiredResearch = "InstaAdvancedFrigateTech",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 75,
        DisplayedName = "$7052",
        Description = "$7053"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Carrier",
        RequiredResearch = "",
        RequiredShipSubSystems = "CapShipProduction",
        DisplayPriority = 110,
        DisplayedName = "$7054",
        Description = "$7055"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Destroyer",
        RequiredResearch = "DestroyerTech",
        RequiredShipSubSystems = "CapShipProduction",
        DisplayPriority = 116,
        DisplayedName = "$7056",
        Description = "$7057"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Shipyard",
        RequiredResearch = "",
        RequiredShipSubSystems = "Hyperspace",
        DisplayPriority = 117,
        DisplayedName = "$7058",
        Description = "$7059"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Battlecruiser",
        RequiredResearch = "BattlecruiserIonWeapons",
        RequiredShipSubSystems = "CapShipProduction",
        DisplayPriority = 118,
        DisplayedName = "$7060",
        Description = "$7061"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_GunTurret",
        RequiredResearch = "",
        RequiredShipSubSystems = "PlatformProduction",
        DisplayPriority = 141,
        DisplayedName = "$7062",
        Description = "$7063"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_IonTurret",
        RequiredResearch = "PlatformIonWeapons",
        RequiredShipSubSystems = "PlatformProduction",
        DisplayPriority = 142,
        DisplayedName = "$7064",
        Description = "$7065"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_ResourceCollector",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 120,
        DisplayedName = "$7066",
        Description = "$7067"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_ResourceController",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 130,
        DisplayedName = "$7068",
        Description = "$7069"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Probe",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 140,
        DisplayedName = "$7070",
        Description = "$7071"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_ProximitySensor",
        RequiredResearch = "SensDisProbe",
        RequiredShipSubSystems = "",
        DisplayPriority = 150,
        DisplayedName = "$7072",
        Description = "$7073"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_ECMProbe",
        RequiredResearch = "ECMProbe",
        RequiredShipSubSystems = "",
        DisplayPriority = 160,
        DisplayedName = "$7074",
        Description = "$7075"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Shipyard_SPG",
        RequiredResearch = "",
        RequiredShipSubSystems = "CapShipProduction",
        DisplayPriority = 117,
        DisplayedName = "$7058",
        Description = "$7059"
    }
}
