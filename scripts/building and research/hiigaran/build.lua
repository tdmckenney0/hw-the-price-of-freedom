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
        ThingToBuild = "Hgn_BC_Production_Fighter",
        RequiredResearch = "",
        RequiredFleetSubSystems = "",
        DisplayPriority = 0,
        DisplayedName = "$7000",
        Description = "$7001"
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
        RequiredResearch = "",
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
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 65,
        DisplayedName = "$7048",
        Description = "$7049"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_IonCannonFrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 70,
        DisplayedName = "$7050",
        Description = "$7051"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_MarineFrigate",
        RequiredResearch = "",
        RequiredShipSubSystems = "FrigateProduction",
        DisplayPriority = 75,
        DisplayedName = "$7052",
        Description = "$7053"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Carrier",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 110,
        DisplayedName = "$7054",
        Description = "$7055"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Destroyer",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
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
        RequiredResearch = "",
        RequiredShipSubSystems = "",
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
        RequiredResearch = "",
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
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 150,
        DisplayedName = "$7072",
        Description = "$7073"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_ECMProbe",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 160,
        DisplayedName = "$7074",
        Description = "$7075"
    },
    {
        Type = Ship,
        ThingToBuild = "Hgn_Shipyard_SPG",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 117,
        DisplayedName = "$7058",
        Description = "$7059"
    },

    -- TPOF Turrets
    {
        Type = SubSystem,
        ThingToBuild = "hgn_coilcannonx3",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1000,
        DisplayedName = "Coil Cannon",
        Description = "Coil Cannon"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_gatlinggun",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1100,
        DisplayedName = "Gatling Gun",
        Description = "Coil Cannon"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_gatlinggunleft",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1110,
        DisplayedName = "Gatling Gun",
        Description = "Gatling Gun"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_gatlinggunright",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1120,
        DisplayedName = "Gatling Gun",
        Description = "Gatling Gun"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_gatlinggunsmall",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1130,
        DisplayedName = "Gatling Gun",
        Description = "Gatling Gun"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_ioncannon",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1200,
        DisplayedName = "Ion Cannon",
        Description = "Ion Cannon"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_lasersmall",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1300,
        DisplayedName = "Small Laser",
        Description = "Small Laser"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_missileturret",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1400,
        DisplayedName = "Missile Turret",
        Description = "Missile Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_missileturretleft",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1410,
        DisplayedName = "Missile Turret",
        Description = "Missile Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_missileturretright",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1420,
        DisplayedName = "Missile Turret",
        Description = "Missile Turret"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_mountedflak",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1500,
        DisplayedName = "Flak Cannon",
        Description = "Flak Cannon"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_plasmabatteryx6",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1600,
        DisplayedName = "Plasma Battery",
        Description = "Plasma Battery"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_railgun",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1700,
        DisplayedName = "Railgun",
        Description = "Railgun"
    },
    {
        Type = SubSystem,
        ThingToBuild = "hgn_smallionturret",
        RequiredResearch = "",
        RequiredShipSubSystems = "",
        DisplayPriority = 1800,
        DisplayedName = "Small Ion Turret",
        Description = "Small Ion Turret"
    }
}
