with (Ball)
{
	phy_linear_velocity_x = 0;
	phy_linear_velocity_y = 0;
	phy_angular_velocity = 0;
	
	phy_position_x = 160;
	phy_position_y = 90;
	
	physics_apply_impulse(phy_com_x, phy_com_y, -15, -30);
	physics_apply_angular_impulse(-30)
}

DrawnPlatformsSpawner.spawner_mode = SpawnerMode.Draw