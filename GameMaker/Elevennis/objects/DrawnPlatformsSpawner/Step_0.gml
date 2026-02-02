if (mouse_check_button(mb_left))
{	
	if (mouse_check_button_pressed(mb_left)) 
	{
		if (point_in_circle(draw_position_x, draw_position_y, size_arrow_x, size_arrow_y, 5))
			changing_draw_area_size = true;
		else
			start_drawing = true;
	}
	
	var in_draw_area = point_in_rectangle(draw_position_x, draw_position_y, draw_area_x1, draw_area_y1, draw_area_x2, draw_area_y2);
	if (changing_draw_area_size)
	{
		var overflow;
		switch (size_arrow_dir)
		{
			case SizeArrowDir.Right:
				draw_area_x2 = clamp(draw_position_x, draw_area_x1 + min_draw_area_width, bounds_x2);
				draw_area_y1 = draw_area_y2 - (draw_area_size / (draw_area_x2 - draw_area_x1));
	
				overflow = min(0, draw_area_y1 - bounds_y1);
				draw_area_y2 -= overflow;
				draw_area_y1 -= overflow;
				break;
				
			case SizeArrowDir.Left:
				draw_area_x1 = clamp(draw_position_x, bounds_x1, draw_area_x2 - min_draw_area_width);
				draw_area_y2 = (draw_area_size / (draw_area_x2 - draw_area_x1)) + draw_area_y1;
			
				overflow = max(0, draw_area_y2 - bounds_y2);
				draw_area_y1 -= overflow;
				draw_area_y2 -= overflow;
				break;
				
			case SizeArrowDir.Up:
				draw_area_y1 = clamp(draw_position_y, bounds_y1, draw_area_y2 - min_draw_area_height);
				draw_area_x2 = (draw_area_size / (draw_area_y2 - draw_area_y1)) + draw_area_x1;
			
				overflow = max(0, draw_area_x2 - bounds_x2);
				draw_area_x1 -= overflow;
				draw_area_x2 -= overflow;
				break;
				
			case SizeArrowDir.Down:
				draw_area_y2 = clamp(draw_position_y, draw_area_y1 + min_draw_area_height, bounds_y2);
				draw_area_x1 = draw_area_x2 - (draw_area_size / (draw_area_y2 - draw_area_y1));
			
				overflow = min(0, draw_area_x1 - bounds_x1);
				draw_area_x2 -= overflow;
				draw_area_x1 -= overflow;
				break;
		}
	}
	else if (start_drawing && in_draw_area)
	{
		surface_index = 0;
		surface_size = initialDrawSurfaceSize;
		surface_centre = surface_size/2;
		
		if (surface_exists(draw_surfaces[0])) surface = draw_surfaces[0];
		else make_new_start_surface = true;
		
		draw_last_position_x = draw_position_x;
		draw_last_position_y = draw_position_y;
		draw_centre_x = draw_position_x;
		draw_centre_y = draw_position_y;
		surface_x = draw_centre_x - surface_centre;
		surface_y = draw_centre_y - surface_centre;
		
		new_start_surface = true;
		start_drawing = false;
		drawing = true;
	}
	
	var total_draw_bound = brush_size + edgeSafety;
	
	out_of_bounds_draw = drawing && in_draw_area &&
		(draw_position_x - total_draw_bound < surface_x || draw_position_x + total_draw_bound >= surface_x + surface_size ||
		draw_position_y - total_draw_bound < surface_y || draw_position_y + total_draw_bound >= surface_y + surface_size);
}
else 
{
	out_of_bounds_draw = false;
	drawing = false;
	
	if (changing_draw_area_size)
	{
		changing_draw_area_size = false;	
		resize_draw_area = true;
	}
	
	if (draw_centre_x != -1)
	{
		create_physics_body = true;
	
		draw_position_x = -1;
		draw_position_y = -1;
		draw_centre_x = -1;
		draw_centre_y = -1;
	}
}

//draw_area_size = (draw_area_x2 - draw_area_x1) * (draw_area_y2 - draw_area_y1);