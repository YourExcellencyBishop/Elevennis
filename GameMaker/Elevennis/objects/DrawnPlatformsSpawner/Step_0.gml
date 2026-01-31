if (mouse_check_button(mb_left))
{
	draw_last_position_x = draw_position_x;
	draw_last_position_y = draw_position_y;
	draw_position_x = floor(mouse_x * GameManager.scale_surf_width);
	draw_position_y = 90//floor(mouse_y * GameManager.scale_surf_height);
	
	if (mouse_check_button_pressed(mb_left))
	{
		surface_index = 0;
		surface_size = initialDrawSurfaceSize;
		surface_centre = surface_size/2;
		
		if (surface_exists(draw_surfaces[0])) surface = draw_surfaces[0];
		else make_new_start_surface = true;
		
		draw_last_position_x = draw_position_x;
		draw_last_position_y = draw_position_y;
		draw_centre_x = floor(mouse_x * GameManager.scale_surf_width);
		draw_centre_y = 90//floor(mouse_y * GameManager.scale_surf_height);
		surface_x = draw_centre_x - surface_centre;
		surface_y = draw_centre_y - surface_centre;
		
		new_start_surface = true;
	}
	
	var total_draw_bound = brush_size + edgeSafety;
	
	out_of_bounds_draw = 
		draw_position_x - total_draw_bound < surface_x || draw_position_x + total_draw_bound >= surface_x + surface_size ||
		draw_position_y - total_draw_bound < surface_y || draw_position_y + total_draw_bound >= surface_y + surface_size;
}
else 
{
	out_of_bounds_draw = false;
	
	if (draw_centre_x != -1)
	{
		create_physics_body = true;
	
		draw_position_x = -1;
		draw_position_y = -1;
		draw_centre_x = -1;
		draw_centre_y = -1;
	}
}