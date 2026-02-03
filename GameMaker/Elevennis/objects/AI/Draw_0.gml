var dt = delta_time / 1000000;


for (i = 1; i < 60*5; i += 5)
{
	var centre_x = Ball.phy_position_x;
	var centre_y = Ball.phy_position_y;
	
	var t = dt * i;
	
	centre_x += Ball.phy_linear_velocity_x * t;
	centre_y += Ball.phy_linear_velocity_y * t + 0.5 * 100 * t * t;
	//show_message(gravity)

	draw_set_alpha(lerp(0.25, 1, 1  - i/120));
	draw_rectangle(centre_x - 2, centre_y - 2, centre_x + 2, centre_y + 2, false);
}

draw_set_alpha(1);
//show_message(1)