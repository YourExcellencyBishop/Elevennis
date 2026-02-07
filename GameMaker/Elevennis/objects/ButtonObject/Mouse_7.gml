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
	
	case ButtonID.None:
	default:
		break;
}