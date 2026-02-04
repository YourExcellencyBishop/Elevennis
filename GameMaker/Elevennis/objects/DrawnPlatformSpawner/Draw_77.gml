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
	
	draw_area_clear = true;
}

var area_w = draw_area_x2 - draw_area_x1;
var area_h = draw_area_y2 - draw_area_y1;

if (draw_area_clear)
{
    if (!surface_exists(draw_area)) draw_area = surface_create(area_w, area_h);

    surface_set_target(draw_area);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
}
else if (resize_draw_area)
{
    if (surface_exists(draw_area)) surface_resize(draw_area, area_w, area_h);
    else draw_area = surface_create(area_w, area_h);

    resize_draw_area = false;
}