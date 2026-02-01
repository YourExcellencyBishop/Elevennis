if (mouse_check_button(mb_left))
{
	draw_last_position_x = draw_position_x;
	draw_last_position_y = draw_position_y;
	draw_position_x = floor(mouse_x * GameManager.scale_surf_width);
	draw_position_y = floor(mouse_y * GameManager.scale_surf_height);
	
	if (mouse_check_button_pressed(mb_left)) 
	{
		if (point_in_circle(draw_position_x, draw_position_y, draw_area_x2 + 2  * sin(current_time / 70), draw_area_y1 + (draw_area_y2 -  draw_area_y1) / 2, 5))
		{
			changing_draw_area_size = true;
		}
		else
		{
			start_drawing = true;
		}
	}
	
	var in_draw_area = point_in_rectangle(draw_position_x, draw_position_y, draw_area_x1, draw_area_y1, draw_area_x2, draw_area_y2);
	
	if (start_drawing && in_draw_area)
	{
		surface_index = 0;
		surface_size = initialDrawSurfaceSize;
		surface_centre = surface_size/2;
		
		if (surface_exists(draw_surfaces[0])) surface = draw_surfaces[0];
		else make_new_start_surface = true;
		
		draw_last_position_x = draw_position_x;
		draw_last_position_y = draw_position_y;
		draw_centre_x = floor(mouse_x * GameManager.scale_surf_width);
		draw_centre_y = floor(mouse_y * GameManager.scale_surf_height);
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
		
		draw_area_x2 = floor(mouse_x * GameManager.scale_surf_width);
		draw_area_y1 = draw_area_y2 - (draw_area_size / (draw_area_x2 - draw_area_x1));
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