platform = instance_create_depth(-50, -50, depth, AiPlatform, 
{
	point_count: 4,
	points_x: [[-20, 20, 20, -20]], 
	points_y: [[-1, -1, 1, 1]],
	body_static: true, 
	collision_group: 1,
	e: 1
});

platform.phy_fixed_rotation = true;

bounds_x1 = room_width - DrawnPlatformSpawner.bounds_x2;
bounds_x2 = room_width - DrawnPlatformSpawner.bounds_x1;
bounds_y1 = DrawnPlatformSpawner.bounds_y1;
bounds_y2 = DrawnPlatformSpawner.bounds_y2;

found_place = false;

function calc_value(a, b, c = 0)
{
    return (a > 0 && b > 0) ? min(a, b) :
           ((a * b <= 0)     ? max(a, b) :
                              c);
}

final_vx = 0;
final_vy = 0;

nx = 0;
ny = 0;

target_x = 160;
target_y = 50;