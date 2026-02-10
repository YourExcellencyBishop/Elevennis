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
		
	case ButtonID.None:
	default:
		break;
}