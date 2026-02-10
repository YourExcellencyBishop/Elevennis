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
		GameManager.start_game();
		break;
		
	case ButtonID.PlaySettings:
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
		GameManager.start_game();
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
			enemy_difficulty = [3, 7, 11][challenge_page];
			set_game_setting(daily_mod_1, daily_mod_vals_1, challenge_page);
			set_game_setting(daily_mod_2, daily_mod_vals_2, challenge_page);
			set_game_setting(daily_mod_3, daily_mod_vals_3, challenge_page);
			start_game()
		}
		break;
		
	case ButtonID.Tutorial:
		break;
		
	case ButtonID.None:
	default:
		break;
}

