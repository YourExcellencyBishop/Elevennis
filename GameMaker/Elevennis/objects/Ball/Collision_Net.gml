with (AI)
{
	found_place = false;
}

GameManager.shake_intensity = lerp(1, 3, phy_speed/5);

var dir = point_direction(0, 0, -phy_col_normal_x, -phy_col_normal_y);
part_type_direction(GameManager._ptype1, dir -20, dir + 20, 0, 0);

part_particles_create(GameManager._ps, phy_collision_x, phy_collision_y, GameManager._ptype1, abs(phy_angular_velocity) / 15);