if (!surface_exists(draw_surfaces[0])) draw_surfaces[0] = surface_create(surface_size, surface_size, surface_rgba8unorm);
if (!surface_exists(draw_surfaces[1])) draw_surfaces[1] = surface_create(surface_size * 2, surface_size * 2, surface_rgba8unorm);
if (!surface_exists(draw_surfaces[2])) draw_surfaces[2] = surface_create(surface_size * 4, surface_size * 4, surface_rgba8unorm);
if (!surface_exists(draw_surfaces[3])) draw_surfaces[3] = surface_create(surface_size * 8, surface_size * 8, surface_rgba8unorm);
if (!surface_exists(draw_surfaces[4])) draw_surfaces[4] = surface_create(surface_size * 16, surface_size * 16, surface_rgba8unorm);

if (create_physics_body)
{
	var temp_surf = surface_create(surface_get_width(surface), surface_get_height(surface));
	
	surface_set_target(temp_surf);
	
	var _x = surface_x > draw_area_x1 ? 0 : draw_area_x1 - surface_x;
	var _y = surface_y > draw_area_y1 ? 0 : draw_area_y1 - surface_y;
	
	draw_surface_part(surface, _x, _y, draw_area_x2 - (surface_x + _x), draw_area_y2 - (surface_y + _y), _x, _y)
	
	surface_free(surface);
	surface = temp_surf;
	
	surface_reset_target();
	
	creation_data = CreateEdgeSurface(surface, global.SupportR8UnormSurface);
}

if (new_start_surface)
{
	if (make_new_start_surface)
	{
		draw_surfaces[0] = surface_create(surface_size, surface_size, surface_rgba8unorm);
		surface = draw_surfaces[0];
	
		make_new_start_surface = false;
	}
	
	surface_set_target(surface);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
	
	new_start_surface = false;
}

if (out_of_bounds_draw)
{
	var prev_surface_size = surface_size;
	var surface_temp = surface;
	
	surface_index++;
	surface_size *= 2;
	surface_centre = surface_size / 2;
	
	surface_x = draw_centre_x - surface_centre;
	surface_y = draw_centre_y - surface_centre;
	
	if (surface_index < array_length(draw_surfaces) && surface_exists(draw_surfaces[surface_index]))
		surface = draw_surfaces[surface_index];
	else
	{
		draw_surfaces[surface_index] = surface_create(surface_size, surface_size, surface_rgba8unorm);
		surface = draw_surfaces[surface_index];
	}
	
	surface_set_target(surface);
	draw_clear_alpha(c_black, 0);
	draw_surface(surface_temp, prev_surface_size / 2 , prev_surface_size / 2);
	surface_reset_target();
}

if (draw_area_clear)
{
	if (surface_exists(draw_area))
	{
		surface_set_target(draw_area);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
	}
	else
	{
		draw_area = surface_create(draw_area_x2 - draw_area_x1, draw_area_y2 - draw_area_y1);
	}
}