global.SupportR8UnormSurface = surface_format_is_supported(surface_r8unorm);
global.trace_dirs_x = [ 1, 1, 0, -1, -1, -1,  0, 1 ];
global.trace_dirs_y = [ 0, 1, 1,  1,  0, -1, -1,-1 ];


show_debug_overlay(1);

//show_message(surface_get_width(application_surface))
//surface_resize(application_surface, 160, 90);


instance_create_depth(0, 0, depth - 1, PhysicsBodySpawner);