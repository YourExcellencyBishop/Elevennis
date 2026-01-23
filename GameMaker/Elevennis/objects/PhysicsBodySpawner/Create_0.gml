//CreatePhysicsBodies(sprite_index, 0.5, 0.5);

draw_centre_x = -1;
draw_centre_y = -1;

draw_position_x = -1;
draw_position_y = -1;

draw_last_position_x = -1;
draw_last_position_y = -1;

brush_size = 8;

surface_size = initialDrawSurfaceSize;
draw_surfaces = [surface_create(surface_size, surface_size, SupportR8Unorm ? surface_rgba4unorm : surface_rgba8unorm)];
surface_index = 0;
surface = draw_surfaces[surface_index];