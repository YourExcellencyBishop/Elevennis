shake_intensity = lerp(shake_intensity, 0, 0.1);

if (layer_get_visible(CreditsLayer) && mouse_check_button_pressed(mb_left))
{
	credits_clicks--;
	
	if (credits_clicks == 0)
	{
		LoadMenu(LoadScreenLayer);
		GameManager.alarm[3] = game_get_speed(gamespeed_fps) * 1;
	}
}