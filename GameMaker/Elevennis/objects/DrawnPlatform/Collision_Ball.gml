with (character.platform_spawner)
{
	spawner_mode = SpawnerMode.ChangeSize;
	start_drawing = false;
	drawing = false;
	create_physics_body = drew;
}

with (character.enemy.platform_spawner)
{
	spawner_mode = SpawnerMode.Draw;
	changing_draw_area_size = false;
	resize_draw_area = true;
}

with (other)
{
	phy_speed_x = -phy_col_normal_x * other.swing;
	phy_speed_y = -phy_col_normal_y * other.swing;
	
	last_touch = other.character;
}

if (GameManager.tutorial && TutorialManager.tutorial_state <= TutorialState.BallReturns)
{
	physics_pause_enable(true);
	character.platform_spawner.paddles = 0;
	TutorialManager.destroy_instance = self;
	TutorialManager.tutorial_state = TutorialState.ExplainPaddle1;
}
else
{
	with (DrawnPlatform)
	{
		if (character == other.character)
		{
			character.platform_spawner.paddles = 0; //check
			instance_destroy();
		}
	}
}