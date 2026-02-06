// Pause
if (!paused) 
{
	alarm[0] = -1;
	exit;
}

fx_set_parameter(game_blur, "g_intensity", lerp(fx_get_parameter(game_blur, "g_intensity"), 1, 0.1));

if (fx_get_parameter(game_blur, "g_intensity") == 1) { alarm[0] = -1; }
else { alarm[0] = 1; }