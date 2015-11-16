dofilepath("data:scripts\\SCAR\\SCAR_Util.lua")
obj_prim_newobj_id = 0

function OnInit()
	Rule_Add("Rule_Init")
end

function Rule_Init()
	Event_Start( "IntelEvent_Intro" )
	SobGroup_CreateShip("MSGroup", "hgn_resourcecollector")
	SobGroup_ExitHyperSpace ("MSGroup", "MS_EnterVolume")
	Rule_Add( "Rule_Player_Wins" )
	Rule_Remove( "Rule_Init" )
end

function Rule_Player_Wins()
	if  Player_GetRU(0) >= 200 then
		Objective_SetState(obj_prim_newobj_id, OS_Complete)
		Event_Start( "IntelEvent_Finale" )
		Rule_Remove("Rule_Player_Wins")
	end 
end

Events = {}
Events.IntelEvent_Intro = 
{ 
	{ 
		{
			"Sound_EnableAllSpeech( 1 )",
			""
		}, 
		{
			"Sound_EnterIntelEvent()",
			""
		}, 
		{
			"Universe_EnableSkip(1)",
			""
		}, 
		HW2_LocationCardEvent( "Postmortem Tutorial - Mission 3", 5 ), 
	}, 
	{ 
		HW2_Letterbox( 1 ), 
		HW2_Wait( 2 ), 
	}, 
	{
		{
			"obj_prim_newobj_id = Objective_Add( 'Gather Resources', OT_Primary )",
			""
		}, 
		{
			"Objective_AddDescription( obj_prim_newobj_id, 'Gather 200RU to win the mission.')",
			""
		}, 
		HW2_SubTitleEvent( Actor_FleetIntel, "Gather 200RU to win the mission.", 4 ),
	},
	{
		HW2_Wait( 1 ), 
	},
	{
		HW2_Letterbox( 0 ), 
		HW2_Wait( 2 ), 
		{
			"Universe_EnableSkip(0)",
			""
		},
		{
			"Sound_ExitIntelEvent()",
			""
		},
	},
}
Events.IntelEvent_Finale = 
{
	{ 
		{
			[[Universe_Fade( 1, 2 )]],
			[[]],
		},
		HW2_Wait(3),
	}, 
	{
		HW2_LocationCardEvent("MISSION SUCCESSFUL", 4),
	}, 
	{
		HW2_Wait(2),
	}, 
	{ 
		{
			[[Camera_AllowControl(1)]],
			[[]],
		}, 
		{
			[[setMissionComplete( 1 )]],
			[[]],
		}, 
	}, 
}