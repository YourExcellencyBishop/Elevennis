draw_centre_x = -1;
draw_centre_y = -1;

draw_position_x = -1;
draw_position_y = -1;

draw_last_position_x = -1;
draw_last_position_y = -1;

brush_size = 2;

surface_size = initialDrawSurfaceSize;
draw_surfaces = array_create(5, -1);
surface_index = 0;
surface = -1;

surface_centre = -1;
surface_x = -1;
surface_y = -1;

out_of_bounds_draw = -1;
make_new_start_surface = false;
new_start_surface = false;

create_physics_body = false;
creation_data = -1;

drawing = false;

draw_area = -1;

draw_area_x1 = 20;
draw_area_x2 = 100;
draw_area_y1 = 80;
draw_area_y2 = 160;

draw_area_size = (draw_area_x2 - draw_area_x1) * (draw_area_y2 - draw_area_y1);
changing_draw_area_size = false;

resize_draw_area = false;

size_arrow_x = -1;
size_arrow_y = -1;
size_arrow_rot = 0;

draw_area_clear = false;
start_drawing = false;

enum SizeArrowDir
{
	Up, Down, Left, Right
}

size_arrow_dir = SizeArrowDir.Down;

bounds_x1 = 20;
bounds_y1 = 20;
bounds_x2 = 140;
bounds_y2 = 160;

min_draw_area_width = draw_area_size / (bounds_y2 - bounds_y1);
min_draw_area_height = draw_area_size / (bounds_x2 - bounds_x1);