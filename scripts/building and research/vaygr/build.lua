-- Cold Fusion LUA Decompiler v1.0.0
-- By 4E534B
-- Date: 08-15-2021 Time: 20:23:17
-- On error(s), send source (compiled) file to 4E534B@gmail.com

Ship = 0
SubSystem = 1
build = {
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Production_Fighter",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7100",
        Description = "$7101"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Production_Fighter",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7100",
        Description = "$7101"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Production_Corvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7102",
        Description = "$7103"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Production_Corvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7102",
        Description = "$7103"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Production_Frigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7104",
        Description = "$7105"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Production_Frigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7104",
        Description = "$7105"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Module_PlatformControl",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7108",
        Description = "$7109"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Module_PlatformControl",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7108",
        Description = "$7109"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_BC_Production_Fighter",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7100",
        Description = "$7101"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Module_CloakGenerator",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 15,
        DisplayedName = "$7118",
        Description = "$7119"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Module_CloakGenerator",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 15,
        DisplayedName = "$7118",
        Description = "$7119"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Module_HyperspaceInhibitor",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 16,
        DisplayedName = "$7116",
        Description = "$7117"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Module_HyperspaceInhibitor",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 16,
        DisplayedName = "$7116",
        Description = "$7117"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Module_FireControl",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 21,
        DisplayedName = "$7120",
        Description = "$7121"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Module_FireControl",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 21,
        DisplayedName = "$7120",
        Description = "$7121"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Module_Hyperspace",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 20,
        DisplayedName = "$7114",
        Description = "$7115"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Module_Hyperspace",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 20,
        DisplayedName = "$7114",
        Description = "$7115"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Sensors_AdvancedArray",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 25,
        DisplayedName = "$7122",
        Description = "$7123"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Sensors_AdvancedArray",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 25,
        DisplayedName = "$7122",
        Description = "$7123"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_C_Sensors_DetectHyperspace",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 30,
        DisplayedName = "$7126",
        Description = "$7127"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_MS_Sensors_DetectHyperspace",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 30,
        DisplayedName = "$7126",
        Description = "$7127"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Scout",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 20,
        DisplayedName = "$7130",
        Description = "$7131"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Interceptor",
        RequiredResearch = "",
        RequiredShipSubSystems = "FighterProduction",
        DisplayPriority = 21,
        DisplayedName = "$7132",
        Description = "$7133"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Bomber",
        RequiredResearch = "",
        RequiredShipSubSystems = "FighterProduction",
        DisplayPriority = 22,
        DisplayedName = "$7134",
        Description = "$7135"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_LanceFighter",
        RequiredResearch = "",
        RequiredShipSubSystems = "FighterProduction",
        DisplayPriority = 23,
        DisplayedName = "$7136",
        Description = "$7137"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_MissileCorvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 100,
        DisplayedName = "$7138",
        Description = "$7139"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_LaserCorvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 105,
        DisplayedName = "$7140",
        Description = "$7141"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_MinelayerCorvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 115,
        DisplayedName = "$7142",
        Description = "$7143"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_CommandCorvette",
        RequiredResearch = "",
        RequiredShipSubSystems = "CorvetteProduction",
        DisplayPriority = 110,
        DisplayedName = "$7144",
        Description = "$7145"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_AssaultFrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 220,
        DisplayedName = "$7146",
        Description = "$7147"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_HeavyMissileFrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 200,
        DisplayedName = "$7148",
        Description = "$7149"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_InfiltratorFrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 230,
        DisplayedName = "$7150",
        Description = "$7151"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Destroyer",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 300,
        DisplayedName = "$7152",
        Description = "$7153"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Carrier",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 310,
        DisplayedName = "$7154",
        Description = "$7155"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_ShipYard",
        RequiredResearch = "",
        RequiredShipSubSystems = "Hyperspace",
        DisplayPriority = 320,
        DisplayedName = "$7156",
        Description = "$7157"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_BattleCruiser",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 330,
        DisplayedName = "$7158",
        Description = "$7159"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_WeaponPlatform_gun",
        RequiredResearch = "",
        RequiredShipSubSystems = "PlatformProduction",
        DisplayPriority = 400,
        DisplayedName = "$7160",
        Description = "$7161"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_WeaponPlatform_missile",
        RequiredResearch = "",
        RequiredShipSubSystems = "PlatformProduction",
        DisplayPriority = 410,
        DisplayedName = "$7162",
        Description = "$7163"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_ResourceCollector",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 500,
        DisplayedName = "$7164",
        Description = "$7165"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_ResourceController",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 510,
        DisplayedName = "$7166",
        Description = "$7167"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_HyperSpace_Platform",
        RequiredResearch = "",
        RequiredShipSubSystems = "PlatformProduction",
        DisplayPriority = 520,
        DisplayedName = "$7174",
        Description = "$7175"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Probe",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 540,
        DisplayedName = "$7168",
        Description = "$7169"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Probe_Prox",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 550,
        DisplayedName = "$7170",
        Description = "$7171"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_Probe_ECM",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 560,
        DisplayedName = "$7172",
        Description = "$7173"
    },
    {
        Type = Ship,
        ThingToBuild = "Vgr_PlanetKillerMissile",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 612,
        DisplayedName = "Honking big planet killing missile",
        Description = ""
    },

    -- TPOF Turrets
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Flakturret",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1000,
        DisplayedName = "Flak Turret",
        Description = "Flak Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Flakturretleft",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1110,
        DisplayedName = "Flak Turret",
        Description = "Flak Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Flakturretright",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1120,
        DisplayedName = "Flak Turret",
        Description = "Flak Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Ionbeamturret",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 2000,
        DisplayedName = "Ion Turret",
        Description = "Ion Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Missilebay",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 3000,
        DisplayedName = "Missile Bay",
        Description = "Missile Bay"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Pmortarfrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 5000,
        DisplayedName = "Plasma Mortar",
        Description = "Plasma Mortar"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Pmortarfrigatebottom",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 5110,
        DisplayedName = "Plasma Mortar",
        Description = "Plasma Mortar"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Pmortarfrigateleft",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 5120,
        DisplayedName = "Plasma Mortar",
        Description = "Plasma Mortar"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Pmortarfrigateright",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 5130,
        DisplayedName = "Plasma Mortar",
        Description = "Plasma Mortar"
    },
    {
        Type = SubSystem,
        ThingToBuild = "Vgr_Railgun",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 6000,
        DisplayedName = "Railgun",
        Description = "Railgun"
    }
}
