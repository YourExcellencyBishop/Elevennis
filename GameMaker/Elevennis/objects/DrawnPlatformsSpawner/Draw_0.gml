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

if (creation_data != -1) draw_surface(creation_data.surface, surface_x, surface_y);

draw_rectangle(draw_area_x1, draw_area_y1, draw_area_x2, draw_area_y2, true);
