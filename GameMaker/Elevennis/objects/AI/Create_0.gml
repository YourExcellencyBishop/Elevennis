event_inherited();

out_of_play_1 = MakeBoxSensor(room_width - 1, room_height - 3, bounds_x2, room_height, OutZone, depth);
out_of_play_1.color = c_yellow;
out_of_play_1.character = id;
out_of_play_1.func = function()
	{
		with(other.collision)
		{
			if (last_touch != INVALID) { last_touch.enemy.total_score++; }
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

platform = instance_create_depth(-50, -50, depth, AiPlatform, 
{
	point_count: 4,
	points_x: [[-20, 20, 20, -20]], 
	points_y: [[-1, -1, 1, 1]],
	body_static: true, 
	collision_group: 1,
	e: 1,
	character: id
});
platform.phy_fixed_rotation = true;

found_place = false;

// make dynamic
target_x = 160;
target_y = 50;

function get_time_roots(a, b)
{
    return (a > 0 && b > 0) ? min(a, b) :
           ((a * b <= 0)    ? max(a, b) :
                              infinity);
}

/*/
 *
 *  AI difficulty properties:
 *	Draw Length (Power)
 *	Draw Speed
 *	Draw Time
 *	Angle
 *
/*/