with (other)
{
	if (phy_linear_velocity_x > 0)
		physics_apply_impulse(phy_position_x, phy_position_y, -phy_linear_velocity_x * 0.8, -phy_linear_velocity_y * 0.8)
}