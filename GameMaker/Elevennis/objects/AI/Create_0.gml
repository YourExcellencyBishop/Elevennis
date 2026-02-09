event_inherited();

out_of_play_1 = MakeBoxSensor(room_width - 1, room_height - 3, bounds_x2, room_height, OutZone, depth);
out_of_play_1.color = c_yellow;
out_of_play_1.character = id;
out_of_play_1.func = function()
{
	with(other.collision)
	{
		if (last_touch != INVALID) { last_touch.enemy.total_score++; }
		
		if (!GameManager.endless && last_touch.enemy.total_score == GameManager.win_score)
		{
			GameManager.end_game("EndScreen");
			return;
		}
	}
	
	with (GameManager)
	{
		reset_game();
	}
}

out_of_play_2 = MakeBoxSensor(room_width / 2 + GameManager.net_thickness, room_height - 3, bounds_x1, room_height, OutZone, depth);
out_of_play_2.color = c_yellow;
out_of_play_2.character = id;
out_of_play_2.func = out_of_play_1.func;

//platform = instance_create_depth(-50, -50, depth, AiPlatform, 
//{
//	point_count: 4,
//	points_x: [[-20, 20, 20, -20]], 
//	points_y: [[-1, -1, 1, 1]],
//	body_static: true, 
//	collision_group: -1,
//	e: 1,
//	character: id
//});
//platform.phy_fixed_rotation = true;

found_place = false;

// make dynamic
target_x = 160;
target_y = 50;

nx = INVALID;
ny = INVALID;

draw_start_x = INVALID;
draw_start_y = INVALID;

draw_end_x = INVALID;
draw_end_y = INVALID;

draw_centre_x = INVALID;
draw_centre_y = INVALID;

draw_allowance = platform_spawner.brush_size;

function get_time_roots(a, b)
{
    return (a > 0 && b > 0) ? min(a, b) :
           ((a * b <= 0)    ? max(a, b) :
                              infinity);
}

draw_speed = lerp(0.25, 0.5, difficulty * difficulty);

time_range_low = 0.5 - lerp(0.4, 0.1, difficulty);
time_range_high = 0.5 + lerp(0.4, 0.1, difficulty);

max_position_variance = 25;

angle_accuracy = difficulty;
angle_variance = degtorad(45 * (1 - difficulty));

max_draw_length = 20;
min_draw_length = 2;

draw_length = 20;

max_draw_delay = game_get_speed(gamespeed_fps) * 2;
draw_delay = INVALID;

/*/
 *
 *  AI difficulty properties:
 *	Draw Length (Power)
 *	Draw Speed
 *	Draw Time
 *	Angle
 *
/*/