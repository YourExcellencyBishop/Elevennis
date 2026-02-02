with (other)
{
	physics_apply_impulse(phy_com_x, phy_com_y, -phy_linear_velocity_x * 0.8, -sign(phy_linear_velocity_y) * phy_linear_velocity_y * 0.8);
}

DrawnPlatformsSpawner.spawner_mode = SpawnerMode.Draw;