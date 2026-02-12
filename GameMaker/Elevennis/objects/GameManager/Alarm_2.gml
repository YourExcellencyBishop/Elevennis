if (audio_is_playing(snd_main_menu))
{
	audio_stop_all();
	alarm[2] = game_get_speed(gamespeed_fps) * 2;
	exit;
}

start_game();
alarm[2] = -1;