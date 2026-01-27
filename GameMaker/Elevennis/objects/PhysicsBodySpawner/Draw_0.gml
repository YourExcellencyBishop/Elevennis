//var s = 20;
//draw_sprite_ext(sprite_index, 0, x, y, s, s, 0, c_white, 1);

var precision = 100;
if (draw_centre_x != -1 && surface_exists(surface))
{	

	surface_set_target(surface);
	
	var draw_part_x = draw_last_position_x;
	var draw_part_y = draw_last_position_y;
	
	var part_x_incr = (draw_position_x - draw_last_position_x) / precision;
	var part_y_incr = (draw_position_y - draw_last_position_y) / precision;
	
	if (part_x_incr > 0 || part_y_incr > 0)
	{
		repeat(precision)
		{
			draw_circle(draw_part_x - surface_x, draw_part_y - surface_y, brush_size, false);
			draw_part_x += part_x_incr;
			draw_part_y += part_y_incr;
		}
	}
	else draw_circle(draw_position_x - surface_x, draw_position_y - surface_y, brush_size, false);
	
	surface_reset_target();

	if (useDebug)
		draw_rectangle_colour(surface_x, surface_y, surface_x + surface_size, surface_y + surface_size, c_red, c_red, c_red, c_red, false)
	
	draw_surface(surface, surface_x, surface_y);
}

if (creation_data != -1) draw_surface(creation_data.surface, surface_x, surface_y);
