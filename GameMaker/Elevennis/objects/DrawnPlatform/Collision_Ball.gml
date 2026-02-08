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
	var spd = phy_speed;
	phy_speed_x = (phy_speed_x / spd) * other.swing;
	phy_speed_y = (phy_speed_y / spd) * other.swing;
	
	last_touch = other.character;
}

with (DrawnPlatform)
{
	if (character == other.character)
	{
		character.platform_spawner.paddles = 0;
		instance_destroy();
	}
}