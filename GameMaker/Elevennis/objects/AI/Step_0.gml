if (!platform_spawner.drawing)
{
	#macro EPS 0.0001

	var grv = global.gravity_y;

	var y0 = Ball.phy_position_y;
	var a = 0.5 * grv;
	var b = Ball.phy_linear_velocity_y;

	// y1 < pos_y + vel_y * t + 1/2 * g *t^2 < y2

	var ty1 = -1, ty2 = -1;

	// Y1
	var c = y0 - (platform_spawner.draw_area_y1 + draw_allowance);
	var sqrt_disc;
	var disc = b*b - 4*a*c;

	var y1r1 = -1, y1r2 = -1;

	if (disc < EPS)
	{
		if (y0 > (platform_spawner.draw_area_y1 + draw_allowance)) { y1r1 = 0; y1r2 = infinity; }
		else { exit; }
	}
	else
	{
		sqrt_disc = sqrt(disc);
		if (y0 > (platform_spawner.draw_area_y1 + draw_allowance)) 
		{
			y1r1 = 0; y1r2 = get_time_roots((-b - sqrt_disc) / (2 * a), (-b + sqrt_disc) / (2 * a)); 
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
	c = y0 - (platform_spawner.draw_area_y2 - draw_allowance);
	disc = b*b - 4*a*c;

	var y2r1 = -1, y2r2 = -1;

	if (disc < EPS)
	{
		if (y0 < (platform_spawner.draw_area_y2 - draw_allowance)) { y2r1 = 0; y2r2 = infinity;  }
		else { exit; }
	}
	else
	{
		sqrt_disc = sqrt(disc);
		if (y0 < (platform_spawner.draw_area_y2 - draw_allowance)) 
		{
			y2r1 = 0; y2r2 = get_time_roots((-b - sqrt_disc) / (2 * a), (-b + sqrt_disc) / (2 * a)); 
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

	var tx1 = ((platform_spawner.draw_area_x1 + draw_allowance) - Ball.phy_position_x) / Ball.phy_linear_velocity_x;
	var tx2 = ((platform_spawner.draw_area_x2 - draw_allowance) - Ball.phy_position_x) / Ball.phy_linear_velocity_x;

	var start_tx = min(tx1, tx2);
	var end_tx   = max(tx1, tx2);

	var start_ty = min(ty1, ty2);
	var end_ty   = max(ty1, ty2);

	var start_t = max(start_tx, start_ty);
	var end_t   = min(end_tx, end_ty);

	// Only future times
	start_t = max(start_t, 0);
	end_t = max(end_t, 0);

	if (start_t < end_t && platform_spawner.spawner_mode == SpawnerMode.Draw)
	{	
		if (!found_place)
		{
			var future_time = lerp(start_t, end_t, random_range(0.3, 0.7));

			var ball_vx = Ball.phy_linear_velocity_x * future_time;
			var ball_vy = Ball.phy_linear_velocity_y * future_time + 0.5 * grv * future_time * future_time;

			draw_centre_x = Ball.phy_position_x + ball_vx;
			draw_centre_y = Ball.phy_position_y + ball_vy;
			
			//platform.phy_position_x = draw_centre_x;
			//platform.phy_position_y = draw_centre_y;
			
			var ball_speed = sqrt(sqr(ball_vx) + sqr(ball_vy));
		
			if (ball_speed > 0)
			{
				nx = -(ball_vx / ball_speed);
				ny = -(ball_vy / ball_speed);
			
				var tx = target_x - draw_centre_x;
				var ty =  target_y - draw_centre_y;
			
				var t_len = sqrt(tx*tx + ty*ty);
				tx /= t_len;
				ty /= t_len;
			
				nx += tx;
				ny += ty;
			
				var n_len = sqrt(nx*nx + ny*ny);
			
				nx /= n_len;
				ny /= n_len;
			
				var angle = arctan2(nx, -ny);
				var x_end = cos(angle) * 10;
				var y_end = sin(angle) * 10;
				//platform.phy_rotation = radtodeg(angle);
			
				draw_start_x = draw_centre_x + x_end;
				draw_start_y = draw_centre_y + y_end;
			
				draw_end_x = draw_centre_x - x_end;
				draw_end_y = draw_centre_y - y_end;
			
				with (platform_spawner)
				{
					drawing = true;
					prev_brush_position_x = other.draw_start_x;
					prev_brush_position_y = other.draw_start_y;
					brush_position_x = prev_brush_position_x;
					brush_position_y = prev_brush_position_y;
				}
			}
		
			found_place = true;
		}
	}
	else { found_place = false; }
}
else
{
	with (platform_spawner)
	{
		prev_brush_position_x = brush_position_x;
		prev_brush_position_y = brush_position_y;
		brush_position_x = lerp(brush_position_x, other.draw_end_x, 0.35);
		brush_position_y = lerp(brush_position_y, other.draw_end_y, 0.35);
		
		if (in_draw_area) { drew = true; }
	
		if (abs(brush_position_x - other.draw_end_x) <= 1 && abs(brush_position_y - other.draw_end_y) <= 1)
		{
			drawing = false;
			brush_position_x = other.draw_end_x;
			brush_position_y = other.draw_end_y;
			create_physics_body = drew;
		}
	}
}