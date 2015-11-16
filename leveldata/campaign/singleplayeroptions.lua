-- LuaDC version 0.9.20
-- 11/11/2008 7:33:06 PM
-- LuaDC by Age2uN
-- on error send source file (compiled lua) and this outputfile to Age2uN@gmx.net
--
GUID =
    { 121, 93, 124, 21, 226, 37, 142, 64, 153, 28, 93, 26, 236, 117, 171, 149, }
GameRulesName = "Single Player"
Description = "No description"
Directories =
{
    Levels = "data:LevelData\\Campaign",
    AI = "data:AI\\", }
GameSetupOptions =
    {
    {
        name = "resources",
        locName = "$3240",
        tooltip = "$3232",
        default = 1,
        visible = 1,
        choices =
            { "$3241", "0.5", "$3242", "3.0", "$3243", "2.0", }, },
    {
        name = "unitcaps",
        locName = "$3214",
        tooltip = "$3234",
        default = 0,
        visible = 1,
        choices =
            { "$3215", "SinglePlayer", }, },
    {
        name = "resstart",
        locName = "$3205",
        tooltip = "$3232",
        default = 0,
        visible = 1,
        choices =
            { "$3206", "750", "$3207", "2000", "$3208", "0", }, },
    {
        name = "lockteams",
        locName = "$3220",
        tooltip = "$3235",
        default = 0,
        visible = 1,
        choices =
            { "$3221", "yes", "$3222", "no", }, },
    {
        name = "startlocation",
        locName = "$3225",
        tooltip = "$3237",
        default = 0,
        visible = 1,
        choices =
            { "$3226", "random", "$3227", "fixed", }, },
    }