if (!active) exit;

switch (button_id)
{
	case ButtonID.Resume:
		PauseManager.paused = false;
		PauseManager.update_pause();
		break;
		
	case ButtonID.Settings:
		break;
		
	case ButtonID.Quit:
		GameManager.end_game();
		break;
		
	case ButtonID.StartGame:
		GameManager.tutorial = false;
		GameManager.load_game();
		break;
		
	case ButtonID.PlaySettings:
		LoadMenu(LoadScreenLayer);
		GameManager.alarm[4] = game_get_speed(gamespeed_fps) * 3;
		break;
		
	case ButtonID.PlaySettingsFromMainMenu:
		LoadMenu(PlayMenuLayer);
		break;
		
	case ButtonID.NextPageGameSettings:
		GameManager.set_game_setting_page(GameManager.game_settings_page + 1);
		break;
		
	case ButtonID.PrevPageGameSettings:
		GameManager.set_game_setting_page(GameManager.game_settings_page - 1);
		break;
		
	case ButtonID.NextPageChallenge:
		GameManager.set_challenge_page(GameManager.challenge_page + 1);
		break;
		
	case ButtonID.PrevPageChallenge:
		GameManager.set_challenge_page(GameManager.challenge_page - 1);
		break;
	
	case ButtonID.Rematch:
		GameManager.load_game();
		break;
		
	case ButtonID.Pause:
		with (PauseManager)
		{
			paused = !paused;
			update_pause();
		}
		break;
		
	case ButtonID.Challenge:
		with (GameManager)
		{
			tutorial = false;
			enemy_difficulty = [3, 7, 11][challenge_page];
			set_game_setting(daily_mod_1, daily_mod_vals_1, challenge_page);
			set_game_setting(daily_mod_2, daily_mod_vals_2, challenge_page);
			set_game_setting(daily_mod_3, daily_mod_vals_3, challenge_page);
			load_game()
		}
		break;
		
	case ButtonID.Tutorial:
		with (GameManager)
		{
			tutorial = true;
			endless = true;
			load_game();
		}
		break;
		
	case ButtonID.None:
	default:
		break;
}

