#macro PauseMenuLayer "PauseMenuLayer"
#macro MainMenuLayer "MainMenuLayer"
#macro PlayMenuLayer "PlayMenuLayer"
#macro EndScreenLayer "EndScreen"

function LoadMenu(_target)
{
	if (_target != "") layer_set_visible(_target, true);
	
	switch (_target) 
	{
		case PauseMenuLayer:
			break;
			
		case PlayMenuLayer:
			GameManager.set_game_setting_page(0);
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			break;
			
		case MainMenuLayer:
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(PauseMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			break;
			
		case EndScreenLayer:
			break;
			
		case "":
			layer_set_visible(MainMenuLayer, false);
			layer_set_visible(PlayMenuLayer, false);
			layer_set_visible(EndScreenLayer, false);
			break;
		
		default:
			show_debug_message("No Load Handles For This Menu")
			break;
	}
}