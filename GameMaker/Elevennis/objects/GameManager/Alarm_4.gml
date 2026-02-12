if (audio_is_playing(snd_main_game))
{
	audio_stop_all();
	alarm[4] = game_get_speed(gamespeed_fps) * 2;
	exit;
}

LoadMenu(PlayMenuLayer);
alarm[4] = -1;