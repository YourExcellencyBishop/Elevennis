if (drawing || create_physics_body)
{
	surface_set_target(surface);
	
	var dx = brush_position_x - prev_brush_position_x;
	var dy = brush_position_y - prev_brush_position_y;
	var dist = point_distance(prev_brush_position_x, prev_brush_position_y, brush_position_x, brush_position_y);
							  
	var spacing = max(1, brush_size * 0.5);

	if (dist == 0) draw_circle(brush_position_x - surface_x, brush_position_y - surface_y, brush_size, false);
	else
	{
		var steps = ceil(dist / spacing);
		
		for (var i = 0; i <= steps; i++)
		{
		    var t = i / steps;
		    var _x = prev_brush_position_x + dx * t;
			var _y = prev_brush_position_y + dy * t;

		    draw_circle(_x - surface_x, _y - surface_y, brush_size, false);
		}
	}
	
	surface_reset_target();
	
	surface_set_target(draw_area);
	draw_surface(surface, surface_x - draw_area_x1, surface_y - draw_area_y1);
	surface_reset_target();
	
	draw_surface(draw_area, draw_area_x1, draw_area_y1);
}

draw_set_colour(bounds_color);
draw_rectangle(bounds_x1 - 1, bounds_y1 - 1, bounds_x2 + 1, bounds_y2 + 1, true);
draw_set_colour(c_white);

if (spawner_mode == SpawnerMode.ChangeSize)
{
	var size_arrow_xx = size_arrow_x; 
	var size_arrow_yy = size_arrow_y;
	if (changing_draw_area_size)
	{	
		switch (size_arrow_dir)
		{
			case SizeArrowDir.Right:
			case SizeArrowDir.Left:
				size_arrow_yy = clamp(brush_position_y, draw_area_y1 + 7, draw_area_y2 - 7);
				break;
			case SizeArrowDir.Up:
			case SizeArrowDir.Down:
				size_arrow_xx = clamp(brush_position_x, draw_area_x1 + 7, draw_area_x2 - 7); 
				break;
		}
	}

	draw_sprite_ext(SizeArrow, 0, size_arrow_xx, size_arrow_yy, 1, 1, size_arrow_rot, c_white, 1);
}

if (!PauseManager.ready_to_play)
{
	draw_set_font(InGameFont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	
	//draw_set_colour(c_green)
	//draw_rectangle( 
	//	bounds_centre_x - string_width("Ready? [  X  ]") / 2, bounds_y1 - 5 - string_height("Ready? [  X  ]"), 
	//	bounds_centre_x + string_width("Ready? [  X  ]") / 2, bounds_y1 - 5, false)
	
	//draw_circle(brush_position_x, brush_position_y, 4, false);
	//draw_set_colour(c_white)
	
	var hovering = point_in_rectangle(brush_position_x, brush_position_y, 
		bounds_centre_x - string_width("Ready? [  X  ]") / 2, bounds_y1 - ready_to_play_space - string_height("Ready? [  X  ]"), 
		bounds_centre_x + string_width("Ready? [  X  ]") / 2, bounds_y1 - ready_to_play_space);
	
	var not_ready_text = hovering ? "Ready? [  _  ]" :  "Ready? [     ]";
	
	draw_set_colour(character.ready_to_play ? c_lime : (hovering ? c_yellow : c_maroon));
	draw_text(bounds_centre_x, bounds_y1 - ready_to_play_space, character.ready_to_play ? "Ready? [  X  ]" : not_ready_text);
	draw_set_colour(c_white);
}

if (spawner_mode == SpawnerMode.Draw)
{
	draw_sprite(AreaLock, 0, bounds_x1, bounds_y1);
}