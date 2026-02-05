var dt = delta_time / 1000000;


for (var i = 1; i < 60*5; i += 5)
{
	var centre_x = Ball.phy_position_x;
	var centre_y = Ball.phy_position_y;
	
	var t = dt * i;
	
	centre_x += Ball.phy_linear_velocity_x * t;
	centre_y += Ball.phy_linear_velocity_y * t + 0.5 * global.gravity_y * t * t;

	draw_set_alpha(lerp(0.25, 1, 1  - i/120));
	draw_rectangle(centre_x - 2, centre_y - 2, centre_x + 2, centre_y + 2, false);
}
draw_set_alpha(1);
draw_set_colour(c_yellow);

draw_arrow(platform.phy_position_x, platform.phy_position_y, platform.phy_position_x + nx * 25, platform.phy_position_y + ny * 25, 10)

for (var i = 1; i < 60*5; i += 5)
{
	var centre_x = platform.phy_position_x;
	var centre_y = platform.phy_position_y;
	
	var t = dt * i;
	
	centre_x += final_vx * t;
	centre_y += final_vy * t + 0.5 * global.gravity_y * t * t;

	draw_set_alpha(lerp(0.25, 1, 1  - i/120));
	draw_rectangle(centre_x - 2, centre_y - 2, centre_x + 2, centre_y + 2, false);
}
draw_set_colour(c_white);

draw_set_alpha(1);
//show_message(1)

draw_set_colour(c_blue);
draw_rectangle(bounds_x1, bounds_y1, bounds_x2, bounds_y2, true);
draw_set_colour(c_white);

draw_rectangle(platform.phy_position_x, platform.phy_position_y, platform.phy_position_x + 1, platform.phy_position_y + 1, false);

draw_circle(Ball.phy_position_x, Ball.phy_position_y, 3, false);

draw_rectangle(160, 50, 161, 51, false);