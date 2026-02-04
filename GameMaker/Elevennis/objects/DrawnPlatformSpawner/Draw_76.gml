if (!surface_exists(surface)) 
{ 
	surface = surface_create(surface_width, surface_height, surface_rgba8unorm); 
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
	show_debug_message("Recreated Surface");
}

if (!surface_exists(draw_area)) 
{
	draw_area = surface_create(draw_area_width - 1, draw_area_height - 1); 
	surface_set_target(draw_area);
    draw_clear_alpha(c_black, 0);
	surface_reset_target();
	show_debug_message("Recreated Draw Area");
}