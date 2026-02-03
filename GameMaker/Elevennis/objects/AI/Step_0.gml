var dt = delta_time / 1000000;

var tx1 = max(0, (bounds_x1 - Ball.phy_position_x) / Ball.phy_linear_velocity_x);
var tx2 = max(0, (bounds_x2 - Ball.phy_position_x) / Ball.phy_linear_velocity_x);

var ty1 = max(0, (bounds_y1 - Ball.phy_position_y) / Ball.phy_linear_velocity_y);
var ty2 = max(0, (bounds_y2 - Ball.phy_position_y) / Ball.phy_linear_velocity_y);

var start_tx = min(tx1, tx2);
var end_tx = max(tx1, tx2);

var start_ty = min(ty1, ty2);
var end_ty = max(ty1, ty2);

var start_t = max(start_tx, start_ty);
var end_t = min(end_tx, end_ty);
//dt * 50;

if (start_t < end_t)
{
	if (!found_place)
	{
		var future_time = lerp(start_t, end_t, 0.5);
		show_debug_message(future_time)
	
		var grv = 10;

		var ball_vx = Ball.phy_linear_velocity_x * future_time;
		var ball_vy = Ball.phy_linear_velocity_y * future_time + 0.5 * (grv / 0.1) * future_time * future_time;

		var ball_speed = sqrt(sqr(ball_vx) + sqr(ball_vy));

		if (ball_speed > 0)
		{
			var nx = -(ball_vy / ball_speed);
			platform.phy_rotation = sign(-ball_vx) * radtodeg(arccos(nx * -1));
		}

		platform.phy_position_x = Ball.phy_position_x + ball_vx;
		platform.phy_position_y = Ball.phy_position_y + ball_vy;
		found_place = true;
	}
}
else
{
	found_place = false
}