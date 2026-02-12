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

alarm[1] = -1;