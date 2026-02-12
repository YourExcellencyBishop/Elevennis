if (audio_is_playing(snd_main_menu))
{
	audio_stop_all();
	alarm[1] = game_get_speed(gamespeed_fps) * 2;
	exit;
}

LoadMenu(CreditsLayer);
alarm[1] = -1;