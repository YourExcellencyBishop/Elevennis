#macro EPS 0.0001

var grv = global.gravity_y;

var y0 = Ball.phy_position_y;
var a = 0.5 * grv;
var b = Ball.phy_linear_velocity_y;

// y1 < pos_y + vel_y * t + 1/2 * g *t^2 < y2

var ty1 = -1, ty2 = -1;

// Y1
var c = y0 - bounds_y1;
var sqrt_disc;
var disc = b*b - 4*a*c;

var y1r1 = -1, y1r2 = -1;

if (disc <  EPS)
{
	if (y0 > bounds_y1) { y1r1 = 0; y1r2 = infinity; }
	else { exit; }
}
else
{
	sqrt_disc = sqrt(disc);
	if (y0 > bounds_y1) 
	{
		y1r1 = 0; y1r2 = calc_value((-b - sqrt_disc) / (2 * a), (-b + sqrt_disc) / (2 * a), infinity); 
	}
	else
	{
		y1r1 = (-b - sqrt_disc) / (2 * a);
		if (y1r1 < EPS ) { y1r1 = infinity; }
		y1r2 = (-b + sqrt_disc) / (2 * a);
		if (y1r2 < EPS ) { y1r2 = infinity; }
	}
}

// Y2
c = y0 - bounds_y2;
disc = b*b - 4*a*c;

var y2r1 = -1, y2r2 = -1;

if (disc <  EPS)
{
	if (y0 < bounds_y2) { y2r1 = 0; y2r2 = infinity;  }
	else { exit; }
}
else
{
	sqrt_disc = sqrt(disc);
	if (y0 < bounds_y2) 
	{
		y2r1 = 0; y2r2 = calc_value((-b - sqrt_disc) / (2 * a), (-b + sqrt_disc) / (2 * a), infinity); 
	}
	else 
	{
		y2r1 = (-b - sqrt_disc) / (2 * a);
		if (y2r1 < EPS ) { y2r1 = infinity; }
		y2r2 = (-b + sqrt_disc) / (2 * a);
		if (y2r2 < EPS ) { y2r2 = infinity; }
	}
}

ty1 = max(min(y1r1, y1r2), min(y2r1, y2r2));
ty2 = min(max(y1r1, y1r2), max(y2r1, y2r2));

if (ty1 > ty2) { exit; }

var tx1 = (bounds_x1 - Ball.phy_position_x) / Ball.phy_linear_velocity_x;
var tx2 = (bounds_x2 - Ball.phy_position_x) / Ball.phy_linear_velocity_x;

var start_tx = min(tx1, tx2);
var end_tx   = max(tx1, tx2);

var start_ty = min(ty1, ty2);
var end_ty   = max(ty1, ty2);

var start_t = max(start_tx, start_ty);
var end_t   = min(end_tx, end_ty);

// Only future times
start_t = max(start_t, 0);
end_t = max(end_t, 0);

if (start_t < end_t /*&& DrawnPlatformsSpawner.spawner_mode == SpawnerMode.ChangeSize*/)
{	
	if (!found_place)
	{
		var future_time = lerp(start_t, end_t, 0.5);
		
		show_debug_message(future_time)

		var ball_vx = Ball.phy_linear_velocity_x * future_time;
		var ball_vy = Ball.phy_linear_velocity_y * future_time + 0.5 * grv * future_time * future_time;

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