if (keyboard_check_pressed(vk_escape))
{
	paused = !paused;
	update_pause();
}

var now = get_timer();

if (!ready_to_play)
{
	start_time = now;
	
	ready_to_play = true;
	with (Character)
	{
		other.ready_to_play = other.ready_to_play and ready_to_play;
	}
	
	if (ready_to_play)
	{
		physics_pause_enable(false);
		
		with (DrawnPlatformSpawner)
		{
			spawner_mode = SpawnerMode.Draw;
		}
	}
}

if (paused) { start_time = now; }

if (!GameManager.endless)
{
	var ui_root = layer_get_flexpanel_node(InGameLayer);
	var score_panel = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "TimePanel"));
	var elementId = score_panel.layerElements[0].elementId;

	var seconds_passed = (now - start_time) / 1_000_000;
	var minutes = floor(GameManager.game_length * 60 - (total_time + seconds_passed)) div 60;
	var seconds = floor(GameManager.game_length * 60 - (total_time + seconds_passed)) mod 60;

	if (minutes <= 0 && seconds <= 0)
	{
		GameManager.end_game(EndScreenLayer);
	}

	layer_text_text(elementId, $"Time: {PadWithZeroes(minutes, 2)} : {PadWithZeroes(seconds, 2)}");
}