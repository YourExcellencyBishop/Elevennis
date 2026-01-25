//CreatePhysicsBodies(sprite_index, 0.5, 0.5);

draw_centre_x = -1;
draw_centre_y = -1;

draw_position_x = -1;
draw_position_y = -1;

draw_last_position_x = -1;
draw_last_position_y = -1;

brush_size = 8;

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