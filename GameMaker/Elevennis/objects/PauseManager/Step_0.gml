if (keyboard_check_pressed(vk_escape))
{
	paused = !paused;
	update_pause();
}

if (!ready_to_play)
{
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