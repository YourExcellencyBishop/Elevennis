paused = false;
ready_to_play = false;

layer_name = "PauseLayer";

game_blur = layer_get_fx("BlurLayer");

update_pause = function()
{
	if (paused)
	{
		layer_set_visible(layer_name, true);
		physics_pause_enable(true);
		alarm[0] = 1;
	}
	else
	{
		fx_set_parameter(game_blur, "g_intensity", 0);
		layer_enable_fx("BlurLayer", true);
		layer_set_visible(layer_name, false);
		physics_pause_enable(!ready_to_play);
		instance_activate_all();
	}
}

update_pause();