switch (button_id)
{
	case ButtonID.Resume:
		PauseManager.paused = false;
		PauseManager.update_pause();
		break;
		
	case ButtonID.Settings:
		break;
		
	case ButtonID.Quit:
		game_end();
		break;
	
	case ButtonID.None:
	default:
		break;
}