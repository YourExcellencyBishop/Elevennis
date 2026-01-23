if (mouse_check_button(mb_left))
{
	draw_last_position_x = draw_position_x;
	draw_last_position_y = draw_position_y;
	draw_position_x = mouse_x;
	draw_position_y = mouse_y;
	
	if (mouse_check_button_pressed(mb_left))
	{
		surface_index = 0;
		surface_size = initialDrawSurfaceSize;
		
		if (surface_exists(draw_surfaces[0]))
		{
			surface = draw_surfaces[0];
		}
		else 
		{
			surface = surface_create(surface_size, surface_size, surface_rgba8unorm);
		}
		
		draw_last_position_x = draw_position_x;
		draw_last_position_y = draw_position_y;
		draw_centre_x = mouse_x;
		draw_centre_y = mouse_y;
		
		surface_set_target(surface);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
	}
}
else
{
	var surface_centre = surface_size/2;
	var surface_x = draw_centre_x - surface_centre;
	var surface_y = draw_centre_y - surface_centre;
	
	if (draw_centre_x != -1) 
	{
		CreatePhysicsBodies(surface, surface_x, surface_y);
	}
	
	draw_position_x = -1;
	draw_position_y = -1;
	draw_centre_x = -1;
	draw_centre_y = -1;
}