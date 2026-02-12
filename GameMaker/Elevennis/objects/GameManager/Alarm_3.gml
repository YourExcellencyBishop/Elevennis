if (audio_is_playing(snd_main_game) || audio_is_playing(snd_credits) || audio_is_playing(snd_credits_intro))
{
	audio_stop_all();
	alarm[3] = game_get_speed(gamespeed_fps) * 2;
	exit;
}

LoadMenu(MainMenuLayer);
alarm[3] = -1;