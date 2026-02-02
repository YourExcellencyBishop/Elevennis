//var s = 20;
//draw_sprite_ext(sprite_index, 0, x, y, s, s, 0, c_white, 1);

var precision = 100;
if (draw_centre_x != -1 && surface_exists(surface))
{
	surface_set_target(surface);
	
	var dx = draw_position_x - draw_last_position_x;
	var dy = draw_position_y - draw_last_position_y;
	var dist = point_distance(draw_last_position_x, draw_last_position_y,
	                          draw_position_x, draw_position_y);
							  
	var spacing = max(1, brush_size * 0.5);

	var steps = ceil(dist / spacing);

	if (steps == 0)
		draw_circle(draw_position_x - surface_x, draw_position_y - surface_y, brush_size, false);
	else
		for (var i = 0; i <= steps; i++)
		{
		    var t = i / steps;
		    var _x = lerp(draw_last_position_x, draw_position_x, t);
		    var _y = lerp(draw_last_position_y, draw_position_y, t);

		    draw_circle(_x - surface_x, _y - surface_y, brush_size, false);
		}
	
	surface_reset_target();

	if (useDebug)
		draw_rectangle_colour(surface_x, surface_y, surface_x + surface_size, surface_y + surface_size, c_red, c_red, c_red, c_red, false)
	
	if (!surface_exists(draw_area))
	{
		draw_area = surface_create(draw_area_x2 - draw_area_x1, draw_area_y2 - draw_area_y1);
	}
	
	surface_set_target(draw_area);
	draw_surface(surface, surface_x - draw_area_x1, surface_y - draw_area_y1);
	surface_reset_target();
	
	draw_surface(draw_area, draw_area_x1, draw_area_y1);
}

if (creation_data != -1)
{ 
	draw_surface(creation_data.surface, surface_x, surface_y);
	
	surface_set_target(draw_area);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
}

draw_set_colour(c_red);
draw_rectangle(bounds_x1, bounds_y1, bounds_x2, bounds_y2, true);
draw_set_colour(c_white);

if (changing_draw_area_size)
{
	switch (size_arrow_dir)
	{
		// Right
		case SizeArrowDir.Right:
			var clamped_x2 = clamp(draw_position_x, draw_area_x1 + min_draw_area_width, bounds_x2);
			var new_y1 = draw_area_y2 - (draw_area_size / (clamped_x2 - draw_area_x1));
			
			var sub_y1 = min(0, new_y1 - bounds_y1);
			draw_area_y2 -= sub_y1;
			new_y1 -= sub_y1;
			
			draw_rectangle(draw_area_x1, new_y1, clamped_x2, draw_area_y2, true);
			draw_sprite_ext(SizeArrow, 0, clamped_x2 + size_arrow_sin, clamp(draw_position_y, new_y1 + 7, draw_area_y2 - 7), 
				1, 1, size_arrow_rot, c_white, 1);
			break;
	
		// Left
		case SizeArrowDir.Left:
			var clamped_x1 = clamp(draw_position_x, bounds_x1, draw_area_x2 - min_draw_area_width);
			var new_y2 = (draw_area_size / (draw_area_x2 - clamped_x1)) + draw_area_y1;
			
			var sub_y2 = max(0, new_y2 - bounds_y2);
			draw_area_y1 -= sub_y2;
			new_y2 -= sub_y2;
			
			draw_rectangle(clamped_x1, draw_area_y1, draw_area_x2, new_y2, true);
			draw_sprite_ext(SizeArrow, 0, clamped_x1 + size_arrow_sin, clamp(draw_position_y, draw_area_y1 + 7, new_y2 - 7), 
				1, 1, size_arrow_rot, c_white, 1);
			break;
	
		// Up
		case SizeArrowDir.Up:
			var clamped_y1 = clamp(draw_position_y, bounds_y1, draw_area_y2 - min_draw_area_height);
			var new_x2 = (draw_area_size / (draw_area_y2 - clamped_y1)) + draw_area_x1;
			
			var sub_x2 = max(0, new_x2 - bounds_x2);
			show_debug_message(sub_x2)
			draw_area_x1 -= sub_x2;
			new_x2 -= sub_x2;
			
			draw_rectangle(draw_area_x1, clamped_y1, new_x2, draw_area_y2, true);
			draw_sprite_ext(SizeArrow, 0, clamp(draw_position_x, draw_area_x1 + 7, new_x2 - 7), clamped_y1 + size_arrow_sin, 
				1, 1, size_arrow_rot, c_white, 1);
			break;
	
		// Down
		case SizeArrowDir.Down:
			var clamped_y2 = clamp(draw_position_y, draw_area_y1 + min_draw_area_height, bounds_y2);
			var new_x1 = draw_area_x2 - (draw_area_size / (clamped_y2 - draw_area_y1));
			
			var sub_x1 = min(0, new_x1 - bounds_x1);
			draw_area_x2 -= sub_x1;
			new_x1 -= sub_x1;
			
			draw_rectangle(new_x1, draw_area_y1, draw_area_x2, clamped_y2, true);
			draw_sprite_ext(SizeArrow, 0, clamp(draw_position_x, new_x1 + 7, draw_area_x2 - 7), clamped_y2 + size_arrow_sin, 
				1, 1, size_arrow_rot, c_white, 1);
			break;
	}
}
else
{
	draw_rectangle(draw_area_x1, draw_area_y1, draw_area_x2, draw_area_y2, true);
	draw_sprite_ext(SizeArrow, 0, size_arrow_x, size_arrow_y, 1, 1, size_arrow_rot, c_white, 1);
}