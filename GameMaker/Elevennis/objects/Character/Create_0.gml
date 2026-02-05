platform_spawner = instance_create_depth(0, 0, depth - 1, DrawnPlatformSpawner, 
{
	bounds_x1: bounds_x1,
	bounds_y1: bounds_y1,
	bounds_x2: bounds_x2,
	bounds_y2: bounds_y2,
	draw_area_side: draw_area_side,
	bounds_color: bounds_color,
	out_zone_color: out_zone_color
});