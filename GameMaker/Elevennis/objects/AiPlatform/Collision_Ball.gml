Player.platform_spawner.spawner_mode = SpawnerMode.Draw;
AI.platform_spawner.spawner_mode = SpawnerMode.ChangeSize;

with (other)
{
	var spd = phy_speed;
	phy_speed_x = (phy_speed_x / spd) * other.swing;
	phy_speed_y = (phy_speed_y / spd) * other.swing;
	last_touch = other.character;
}

phy_position_x = -100;
phy_position_y = -100;

with (DrawnPlatform)
{
	instance_destroy();
}