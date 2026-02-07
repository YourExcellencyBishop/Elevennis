//function MakeGameSetting(option_name)
//{
//	//for(var i = 0, n = array_length(layer_get_all()); i < n; i++)
//	//{
//	//	show_message(layer_get_all_elements(layer_get_all()[i]))
//	//}
	
//	var rules_panel = flexpanel_node_get_child(layer_get_flexpanel_node(PlayMenuLayer), "GameRulesPanel");
//	var opt = flexpanel_create_node(flexpanel_node_get_struct(flexpanel_node_get_child(layer_get_flexpanel_node(PlayMenuLayer), "EnemyDifficulty")));
	
//	//show_message(flexpanel_node_get_struct(flexpanel_node_get_child(layer_get_flexpanel_node(PlayMenuLayer), "Text2")))
	
//	var option_panel = flexpanel_create_node(
//	{
//		width: 400, 
//		height: 40,
//		flexDirection: "row",
//		name: option_name, 
//		marginTop:5, 
//		marginBottom:5
//	});
	
//	var temp = layer_text_create(layer_get_id("DynamicElements"), 0, 0, MenuFont, "LOL");
	
//	show_message(flexpanel_node_get_struct(layer_get_flexpanel_node("DynamicElements")))
	
//	var game_setting_text_panel = flexpanel_create_node(
//	{
//		height: 40,
//		name: "Text",
//	});
	
//	//flexpanel_node_insert_child(game_setting_text_panel, flexpanel_node_get_child(layer_get_flexpanel_node("DynamicElements"), "FlexPanel"), 0);
	
//	show_message(flexpanel_node_get_struct(game_setting_text_panel));
	
//	//layer_text_create(layer_get_id("Text2"), 0, 0, MenuFont, "LOL");
	
//	flexpanel_node_insert_child(option_panel, game_setting_text_panel, 0);
	
//	//flexpanel_node_insert_child(rules_panel, option_panel, 1);
//}

