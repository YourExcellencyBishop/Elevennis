#macro PauseMenuLayer "PauseMenuLayer"
#macro MainMenuLayer "MainMenuLayer"
#macro PlayMenuLayer "PlayMenuLayer"
#macro EndScreenLayer "EndScreenLayer"
#macro InGameLayer "InGameLayer"
#macro TutorialLayer "TutorialLayer"
#macro InGameTutorialLayer "InGameTutorialLayer"
#macro LoadScreenLayer "LoadingScreenLayer"
#macro CreditsLayer "CreditsLayer"

function LoadMenu(_target)
{
	if (_target != "") layer_set_visible(_target, true);
	
	switch (_target) 
	{
		case PauseMenuLayer:
			layer_set_visible(InGameLayer, false);
			layer_set_visible(LoadScreenLayer, false);
			break;
			
		case PlayMenuLayer:
			GameManager.reset_to_default();
		
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
			layer_set_visible(LoadScreenLayer, false);
			break;
			
		case MainMenuLayer:
			layer_set_visible(InGameLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			layer_set_visible(TutorialLayer, false);
			layer_set_visible(InGameTutorialLayer, false);
			layer_set_visible(LoadScreenLayer, false);
			
			if (!audio_is_playing(snd_main_menu)) audio_play_sound(snd_main_menu, 1, true);
			
			break;
			
		case EndScreenLayer:
			layer_set_visible(InGameLayer, false);
			layer_set_visible(LoadScreenLayer, false);
			break;
			
		case InGameLayer:
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			layer_set_visible(LoadScreenLayer, false);
			break;
			
		case TutorialLayer:
			layer_set_visible(InGameTutorialLayer, false);
			instance_create_depth(0, 0, depth, TutorialManager);
			layer_set_visible(LoadScreenLayer, false);
			break;
			
		case LoadScreenLayer:
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			layer_set_visible(InGameLayer, false);
			layer_set_visible(TutorialLayer, false);
			layer_set_visible(InGameTutorialLayer, false);
			layer_set_visible(CreditsLayer, false);
			break;
			
		case CreditsLayer:
			layer_set_visible(LoadScreenLayer, false);
			if (!audio_is_playing(snd_credits_intro)) GameManager.credits_intro_sound = audio_play_sound(snd_credits_intro, 1, false);
			
			with (GameManager)
			{
				credits_items = ["Turn up the volume", "Game Credits !!!", all_credits_items[0]];
				credits_item = 1;
				credits_y = [0, 0, 0];
				credits_clicks = 3;
			}
			
			draw_set_font(InGameFont);
			GameManager.credits_y[0] = display_get_gui_height() / 3 * 2;
			GameManager.credits_y[1] = GameManager.credits_y[0] + string_height(GameManager.credits_items[0]) * 10 + display_get_gui_height() / 3;
			GameManager.credits_y[2] = GameManager.credits_y[1] + string_height(GameManager.credits_items[1]) * 10 + display_get_gui_height() / 3;
			break;
			
		case "":
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			layer_set_visible(InGameLayer, false);
			layer_set_visible(TutorialLayer, false);
			layer_set_visible(LoadScreenLayer, false);
			break;
		
		default:
			show_debug_message("No Load Handles For This Menu")
			break;
	}
}