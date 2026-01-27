global.SupportR8UnormSurface = surface_format_is_supported(surface_r8unorm);
global.trace_dirs_x = [ 1, 1, 0, -1, -1, -1,  0, 1 ];
global.trace_dirs_y = [ 0, 1, 1,  1,  0, -1, -1,-1 ];

if (useDebug)
	show_debug_overlay(1);

application_surface_enable(0)
application_surface_draw_enable(0);

surf = -1;
surf_width = 320;
surf_height = 180;

scale_surf_width = surf_width / view_get_wport(view_current);
scale_surf_height = surf_height / view_get_hport(view_current);

instance_create_depth(0, 0, depth - 1, PhysicsBodySpawner);