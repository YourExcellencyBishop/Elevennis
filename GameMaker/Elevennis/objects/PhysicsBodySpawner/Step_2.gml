var surface_centre = surface_size/2;
var surface_x = draw_centre_x - surface_centre;
var surface_y = draw_centre_y - surface_centre;

if (draw_position_x - (brush_size + 1) < surface_x || draw_position_x + (brush_size + 1) >= surface_x + surface_size ||
	draw_position_y - (brush_size + 1) < surface_y || draw_position_y + (brush_size + 1) >= surface_y + surface_size)
{
	var prev_surface_size = surface_size;
	var surface_temp = surface;
	
	surface_index++;
	surface_size *= 2;
	if (surface_index < array_length(draw_surfaces) && surface_exists(draw_surfaces[surface_index]))
	{
		surface = draw_surfaces[surface_index];
	}
	else
	{
		surface = surface_create(surface_size, surface_size, SupportR8Unorm ? surface_rgba4unorm : surface_rgba8unorm);
		draw_surfaces[surface_index] = surface;
	}
	
	surface_set_target(surface);
	draw_clear_alpha(c_black, 0);
	draw_surface(surface_temp, prev_surface_size / 2 , prev_surface_size / 2);
	surface_reset_target();
}