DrawnPlatformSpawner.spawner_mode = SpawnerMode.ChangeSize;

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