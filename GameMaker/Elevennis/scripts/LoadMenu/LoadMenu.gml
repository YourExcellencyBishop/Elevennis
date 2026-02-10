#macro PauseMenuLayer "PauseMenuLayer"
#macro MainMenuLayer "MainMenuLayer"
#macro PlayMenuLayer "PlayMenuLayer"
#macro EndScreenLayer "EndScreenLayer"
#macro InGameLayer "InGameLayer"

function LoadMenu(_target)
{
	if (_target != "") layer_set_visible(_target, true);
	
	switch (_target) 
	{
		case PauseMenuLayer:
			layer_set_visible(InGameLayer, false);
			break;
			
		case PlayMenuLayer:
			GameManager.set_game_setting_page(0);
			GameManager.set_challenge_page(0);
			
			var ui_root = layer_get_flexpanel_node(PlayMenuLayer);
			var setting, elementId;
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "ChallengePages"));
			
			// Mod 1
			elementId = setting.nodes[0].nodes[1].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_1]}: {GameManager.daily_mod__string_vals_1[0]}");
			elementId = setting.nodes[1].nodes[1].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_1]}: {GameManager.daily_mod__string_vals_1[1]}");
			elementId = setting.nodes[2].nodes[1].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_1]}: {GameManager.daily_mod__string_vals_1[2]}");
			
			// Mod 2
			elementId = setting.nodes[0].nodes[2].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_2]}: {GameManager.daily_mod__string_vals_2[0]}");
			elementId = setting.nodes[1].nodes[2].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_2]}: {GameManager.daily_mod__string_vals_2[1]}");
			elementId = setting.nodes[2].nodes[2].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_2]}: {GameManager.daily_mod__string_vals_2[2]}");
			
			// Mod 3
			elementId = setting.nodes[0].nodes[3].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_3]}: {GameManager.daily_mod__string_vals_3[0]}");
			elementId = setting.nodes[1].nodes[3].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_3]}: {GameManager.daily_mod__string_vals_3[1]}");
			elementId = setting.nodes[2].nodes[3].nodes[0].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.mod_list[GameManager.daily_mod_3]}: {GameManager.daily_mod__string_vals_3[2]}");
			
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			layer_set_visible(InGameLayer, false);
			break;
			
		case MainMenuLayer:
		layer_set_visible(InGameLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			break;
			
		case EndScreenLayer:
			layer_set_visible(InGameLayer, false);
			break;
			
		case InGameLayer:
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			break;
			
		case "":
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			layer_set_visible(InGameLayer, false);
			break;
		
		default:
			show_debug_message("No Load Handles For This Menu")
			break;
	}
}