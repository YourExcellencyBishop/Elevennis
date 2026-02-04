with (other)
{
	physics_apply_impulse(phy_com_x, phy_com_y, -phy_linear_velocity_x * 1, -sign(phy_linear_velocity_y) * phy_linear_velocity_y * 1);
}

DrawnPlatformSpawner.spawner_mode = SpawnerMode.Draw;