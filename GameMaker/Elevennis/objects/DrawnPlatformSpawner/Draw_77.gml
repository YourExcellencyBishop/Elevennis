var area_w = draw_area_width;
var area_h = draw_area_height;

if (resize_draw_area)
{
    surface_resize(draw_area, area_w, area_h);
    resize_draw_area = false;
}
else
{
	if (create_physics_body)
	{
		var temp_surf = surface_create(area_w + 2, area_h + 2, surface_rgba8unorm);
		surface_set_target(temp_surf);
		draw_surface(draw_area, 1, 1);
		surface_reset_target();
	
		creation_data = CreateEdgeSurface(temp_surf, global.SupportR8UnormSurface);
		
		drew = false;
		
		surface_set_target(draw_area);
	    draw_clear_alpha(c_black, 0);
		surface_set_target(surface)
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
		surface_reset_target();
	}
}