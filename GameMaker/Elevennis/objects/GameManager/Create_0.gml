global.SupportR8UnormSurface = surface_format_is_supported(surface_r8unorm);
global.trace_dirs_x = [ 1, 1, 0, -1, -1, -1,  0, 1 ];
global.trace_dirs_y = [ 0, 1, 1,  1,  0, -1, -1,-1 ];

global.gravity_x = 0;
global.gravity_y = 10000;

if (useDebug)
{
	show_debug_overlay(1);
	if (!shaders_are_supported()) show_message("Shaders are not supported.");
	if (!shader_is_compiled(OnlyEdgesShader)) show_message($"The shader {shader_get_name(OnlyEdgesShader)} did not compile");
	if (!shader_is_compiled(OnlyEdgesShaderR8)) show_message($"The shader {shader_get_name(OnlyEdgesShaderR8)} did not compile");
}

//show_message(game_get_speed(gamespeed_fps))

//window_set_fullscreen(true)

physics_world_update_iterations(30);

application_surface_enable(0)
application_surface_draw_enable(0);
surface_depth_disable(true);

surf = -1;
surf_width = 320;
surf_height = 180;

room_width = surf_width;
room_height = surf_height;

scale_surf_width = surf_width / view_get_wport(view_current);
scale_surf_height = surf_height / view_get_hport(view_current);

var fix = physics_fixture_create();
physics_fixture_set_collision_group(fix, 1)
physics_fixture_set_restitution(fix, 0.75);
physics_fixture_set_edge_shape(fix, 0, 0, room_width, 0); // top
physics_fixture_bind(fix, id);

physics_fixture_set_edge_shape(fix, room_width, 0, room_width, room_height); // right
physics_fixture_bind(fix, id);

physics_fixture_set_edge_shape(fix, room_width, room_height, 0, room_height); // bottom
physics_fixture_bind(fix, id);

physics_fixture_set_edge_shape(fix, 0, room_height, 0, 0); // left
physics_fixture_bind(fix, id);

physics_fixture_delete(fix);

instance_create_depth(0, 0, depth - 1, DrawnPlatformsSpawner);

var net_thickness = 2;
var net_height = surf_height / 3;

instance_create_depth(surf_width / 2, surf_height - net_height / 2, depth - 1, Net, 
{
	points_x: [-net_thickness, net_thickness, net_thickness, -net_thickness], 
	points_y: [-net_height / 2, -net_height / 2, net_height / 2, net_height / 2],
	point_count: 4,
	body_static: true
});

instance_create_depth(room_width / 2, (room_height - net_height) / 2, depth - 1, SideSeparator, 
{
	half_width: net_thickness, 
	half_height: (room_height - net_height) / 2
});

//instance_create_depth((room_width / 2) / 2, room_height - 1, depth - 1, OutZone, 
//{
//	half_width: room_width / 4, 
//	half_height: 1
//});

instance_create_depth(room_width *3/4, room_height / 2, depth - 1, Rebounder, 
{
	half_width: net_thickness, 
	half_height: room_height / 2
});