character.platform_spawner.spawner_mode = SpawnerMode.ChangeSize;
character.enemy.platform_spawner.spawner_mode = SpawnerMode.Draw;

with (other)
{
	var spd = phy_speed;
	phy_speed_x = (phy_speed_x / spd) * other.swing;
	phy_speed_y = (phy_speed_y / spd) * other.swing;
	
	
	show_debug_message(phy_speed);
}

with (DrawnPlatform)
{
	instance_destroy();
}