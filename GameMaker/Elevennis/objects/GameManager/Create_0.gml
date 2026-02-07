global.SupportR8UnormSurface = surface_format_is_supported(surface_r8unorm);
global.trace_dirs_x = [ 1, 1, 0, -1, -1, -1,  0, 1 ];
global.trace_dirs_y = [ 0, 1, 1,  1,  0, -1, -1,-1 ];

global.gravity_x = 0;
global.gravity_y = 100;

randomise()

if (useDebug)
{
	show_debug_overlay(1);
	if (!shaders_are_supported()) show_message("Shaders are not supported.");
	if (!shader_is_compiled(OnlyEdgesShader)) show_message($"The shader {shader_get_name(OnlyEdgesShader)} did not compile");
	if (!shader_is_compiled(OnlyEdgesShaderR8)) show_message($"The shader {shader_get_name(OnlyEdgesShaderR8)} did not compile");
}

#macro pixelstometerscale 0.1

physics_world_create(pixelstometerscale);
physics_world_gravity(global.gravity_x * pixelstometerscale, global.gravity_y * pixelstometerscale)
physics_world_update_speed(game_get_speed(gamespeed_fps) * 2);

application_surface_enable(1) // Enabled for FX
application_surface_draw_enable(0);
surface_depth_disable(true);

surf = INVALID;
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

game_state = GameState.MainMenu;

enum GameState
{
	MainMenu, MainGame
}

LoadMenu(MainMenuLayer);

var _main_menu_layer = layer_get_flexpanel_node(MainMenuLayer);
var _play_flex = flexpanel_node_get_child(_main_menu_layer, "PlayButton");

//layer_text_text(flexpanel_node_get_struct(_play_flex)[$ "nodes"][0].layerElements[0].elementId, "Bruh");
//show_message(flexpanel_node_get_struct(_play_flex)[$ "nodes"][0].layerElements[0].elementId)
//show_message(flexpanel_node_get_data(_play_flex))

#macro player_bound_x1 40
#macro player_bound_y1 70
#macro player_bound_x2 120
#macro player_bound_y2 160
#macro zone_separator_e 0.75

function start_game()
{
	game_state = GameState.MainGame;
	
	layer_set_visible(MainMenuLayer, false);
	layer_set_visible(PlayMenuLayer, false);
	
	instance_create_depth(x, y, depth, PauseManager);

	net_thickness = 2;
	net_height = surf_height / 3;

	instance_create_depth(room_width / 2, room_height - net_height / 2, depth - 1, Net, 
	{
		points_x: [[-net_thickness, net_thickness, net_thickness, -net_thickness]], 
		points_y: [[-net_height / 2, -net_height / 2, net_height / 2, net_height / 2]],
		point_count: 4,
		body_static: true
	});

	//instance_create_depth(room_width / 2, (room_height - net_height) / 2, depth - 1, SideSeparator, 
	//{
	//	half_width: net_thickness, 
	//	half_height: (room_height - net_height) / 2
	//});

	//instance_create_depth(room_width *3/4, room_height / 2, depth - 1, Rebounder, 
	//{
	//	half_width: net_thickness, 
	//	half_height: room_height / 2
	//});

	player = instance_create_depth(0, 0, depth - 1, Player, 
	{
		bounds_x1: player_bound_x1,
		bounds_y1: player_bound_y1,
		bounds_x2: player_bound_x2,
		bounds_y2: player_bound_y2,
		draw_area_side: 50,
		bounds_color: c_red,
		out_zone_color: c_blue
	});

	instance_create_depth(player_bound_x1, room_height, depth, PhysicsBody,
	{
		point_count: 4, 
		points_x: [[-4, 4, 4, -4]], 
		points_y: [[-12, -12, 12, 12]],
		point_mass: 1,
		body_static: true,
		e: zone_separator_e
	});

	instance_create_depth(player_bound_x2, room_height, depth, PhysicsBody,
	{
		point_count: 4, 
		points_x: [[-4, 4, 4, -4]], 
		points_y: [[-12, -12, 12, 12]],
		point_mass: 1,
		body_static: true,
		e: zone_separator_e
	});

	opponent = instance_create_depth(0, 0, depth - 1, AI, 
	{
		bounds_x1: room_width - player_bound_x2,
		bounds_y1: player_bound_y1,
		bounds_x2: room_width - player_bound_x1,
		bounds_y2: player_bound_y2,
		draw_area_side: sqrt((player_bound_x2 - player_bound_x1) * (player_bound_y2 - player_bound_y1) - 1),
		bounds_color: c_blue,
		out_zone_color: c_red,
		enemy: player,
		difficulty: 11/11
	});

	instance_create_depth(room_width - player_bound_x2, room_height, depth, PhysicsBody,
	{
		point_count: 4, 
		points_x: [[-4, 4, 4, -4]], 
		points_y: [[-12, -12, 12, 12]],
		point_mass: 1,
		body_static: true,
		e: zone_separator_e
	});

	instance_create_depth(room_width - player_bound_x1, room_height, depth, PhysicsBody,
	{
		point_count: 4, 
		points_x: [[-4, 4, 4, -4]], 
		points_y: [[-12, -12, 12, 12]],
		point_mass: 1,
		body_static: true,
		e: zone_separator_e
	});

	player.enemy = opponent;

	ball = instance_create_depth(160, 90, depth, Ball,
	{
		point_count: 4, 
		points_x: [[-10, 10, 10, -10]], 
		points_y: [[-10, -10, 10, 10]],
		point_mass: 1
	});

	reset_game();
}

function reset_game()
{
	physics_pause_enable(true);
	
	with (ball)
	{
		phy_position_x = 160;
		phy_position_y = 90;
		phy_rotation = 0;
		
		phy_linear_velocity_x = 0;
		phy_linear_velocity_y = 0;
		phy_angular_velocity = 0;
		
		physics_apply_impulse(phy_com_x, phy_com_y, irandom(10) % 2 == 0 ? -random_range(15, 20) : random_range(15, 20)  , -random_range(15, 40));
		physics_apply_angular_impulse(random_range(-60, 60))
	}
	
	with (DrawnPlatformSpawner)
	{
		spawner_mode = SpawnerMode.ChangeSize;
	}
	
	with (DrawnPlatform)
	{
		instance_destroy();
	}
	
	PauseManager.ready_to_play = false;
	Character.ready_to_play = false;
}

function end_game(_target_menu = MainMenuLayer)
{
	game_state = GameState.MainMenu;
	
	//fx_set_parameter(PauseManager.game_blur, "g_intensity", 0);
	physics_pause_enable(true);
	instance_activate_all();
	
	with (all)
	{
		if (!persistent) instance_destroy();
	}
	
	LoadMenu(_target_menu);
}