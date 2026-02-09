paused = false;
ready_to_play = false;

game_blur = layer_get_fx("BlurLayer");

update_pause = function()
{
	if (paused)
	{
		var now = get_timer();
		var seconds = (now - start_time) / 1_000_000;
		total_time += seconds;
		LoadMenu(PauseMenuLayer)
		physics_pause_enable(true);
		alarm[0] = 1;
	}
	else
	{
		fx_set_parameter(game_blur, "g_intensity", 0);
		layer_enable_fx("BlurLayer", true);
		LoadMenu(InGameLayer)
		physics_pause_enable(!ready_to_play);
		instance_activate_all();
	}
}

if (GameManager.endless)
{
	var ui_root = layer_get_flexpanel_node(InGameLayer);
	var score_panel = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "TimePanel"));
	var elementId = score_panel.layerElements[0].elementId;
	layer_text_text(elementId, "");
}

update_pause();