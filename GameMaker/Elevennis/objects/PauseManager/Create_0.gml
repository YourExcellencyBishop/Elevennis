paused = false;
layer_name = "PauseLayer";

update_pause = function()
{
	if (paused)
	{
		instance_deactivate_all(true);
		layer_set_visible(layer_name, true);
		physics_pause_enable(true);
	}
	else
	{
		instance_activate_all();
		layer_set_visible(layer_name, false);
		physics_pause_enable(false);
	}
}

update_pause();