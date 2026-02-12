global.SupportR8UnormSurface = surface_format_is_supported(surface_r8unorm);
global.trace_dirs_x = [ 1, 1, 0, -1, -1, -1,  0, 1 ];
global.trace_dirs_y = [ 0, 1, 1,  1,  0, -1, -1,-1 ];

//ParticleSystem1
_ps = part_system_create();
part_system_draw_order(_ps, true);

//ParticleType
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_pixel);
part_type_size(_ptype1, 2, 2, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 10, 20, -4, 0);
part_type_direction(_ptype1, 80, 100, 0, 20);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $0000FF, $0CBAFF, $000000);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 10, 30);

part_system_automatic_draw(_ps, false);
part_system_position(_ps, 0, 0);

icon_rot = 0;

credits_intro_sound = INVALID;

all_credits_items = ["Elevennis by Fintane", "A Game Made For\nThe Reddit\nDaily Games Hackathon", 
	"Game Director\nMe", "Creative Director\nAlso Me", "Executive Producer\nStill Me", "Produces\nMe Again", "Assistant Producer\nMe\n(wearing a different hat)",
	"Lead Game Designer\nMe", "Junior Game Designer\nMe (earlier that morning)", "Systems Designer\nMe (after coffee)",
	"UX Designer\nMe (guessing)", "UI Designer\nMe (hoping for the best)", "Physics Programmer\nMe (breaking everything)",
	"Bug Creator\nMe", "Bug Fixer\nMe (later, angrily)", "Visual Effects Artist\nMe (particles everywhere)", "Composer\nMy Friend (NoNote)", 
	"Playtester\nMe", "Release Manager\nMe (panicking)", "Version Control Manager\nMe (forgot to commit)", "Special Thanks\nYou!!!!\nFor Playing",
	"Extra Special Thanks\nMe obviously"];
	

#macro base_gravity 100
global.gravity_x = 0;
global.gravity_y = base_gravity;

random_set_seed(date_get_day_of_year(date_current_datetime()));

#macro BallEdgesMod 0
#macro GravityMod 1
#macro BallSizeMod 2
#macro WallBounceMod 3
#macro HitPowerMod 4
#macro MaxPaddlesMod 5
#macro BrushSizeMod 6

mod_list = ["Ball Edges", "Gravity", "Ball Size", "Wall Bounce", "Hit Power", "Max Paddles", "Brush Size"];

daily_mod_1 = set_daily_mod(daily_mod_2, daily_mod_3);
daily_mod_2 = set_daily_mod(daily_mod_1, daily_mod_3);
daily_mod_3 = set_daily_mod(daily_mod_2, daily_mod_1);

function reset_to_default()
{
	enemy_difficulty = 6;
	ball_edges = 4;
	gravity_scale = 1;
	ball_radius = 15;
	wall_bounce = 0.75;
	hit_power = 1;
	max_paddles = 4;
	brush_size = 2;
	win_score = 11;
	endless = false;
	game_length = 3;
}

function set_daily_mod(other_mod_1, other_mod_2)
{
	var mod_to_set = -1;
	do 
	{
	    mod_to_set = irandom_range(0, 6);
	} until (mod_to_set != other_mod_1 && mod_to_set != other_mod_2);
	
	return mod_to_set;
}

var mod_vals_1 = set_mod_values(daily_mod_1);
var mod_vals_2 = set_mod_values(daily_mod_2);
var mod_vals_3 = set_mod_values(daily_mod_3);

array_copy(daily_mod_vals_1, 0, mod_vals_1, 0, 3);
array_copy(daily_mod_vals_2, 0, mod_vals_2, 0, 3);
array_copy(daily_mod_vals_3, 0, mod_vals_3, 0, 3);

array_copy(daily_mod__string_vals_1, 0, mod_vals_1, 3, 3);
array_copy(daily_mod__string_vals_2, 0, mod_vals_2, 3, 3);
array_copy(daily_mod__string_vals_3, 0, mod_vals_3, 3, 3);

function set_mod_values(mod_num)
{
	var values = array_create(6, INVALID);
	
	switch (mod_num)
	{
		case BallEdgesMod:
			values[0] = irandom_range(6,9);
			values[3] = values[0] == 9 ? "inf": values[0];
			
			values[1] = irandom_range(4,7);
			values[4] = values[1];
			
			values[2] = irandom_range(3,6);
			values[5] = values[2];
			break;
			
		case GravityMod:
			values[0] = random_range(0.9, 1.1);
			values[0] -= values[0] % 0.1;
			values[3] = $"{string_format(values[0], 1, 1)}x";
			
			values[1] = random_range(0.7, 1.3);
			values[1] -= values[1] % 0.1;
			values[4] = $"{string_format(values[1], 1, 1)}x";
			
			values[2] = random_range(0.5, 1.5);
			values[2] -= values[2] % 0.1;
			values[5] = $"{string_format(values[2], 1, 1)}x";
			break;
		
		case BallSizeMod:
			values[0] = irandom_range(14, 16);
			values[3] = values[0];
			
			values[1] = irandom_range(12, 17);
			values[4] = values[1];
			
			values[2] = irandom_range(10, 15);
			values[5] = values[2];
			break;
			
		case WallBounceMod:
			values[0] = random_range(0.7, 0.8);
			values[0] -= values[0] % 0.05;
			values[3] = values[0];
			
			values[1] = random_range(0.4, 1.2);
			values[1] -= values[1] % 0.05;
			values[4] = values[1];
			
			values[2] = random_range(0.25, 1.5);
			values[2] -= values[2] % 0.05;
			values[5] = values[2];
			break;
			
		case HitPowerMod:
			values[0] = random_range(1, 1.3);
			values[0] -= values[0] % 0.1;
			values[3] = values[0];
			
			values[1] = random_range(1, 1.6);
			values[1] -= values[1] % 0.1;
			values[4] = values[1];
			
			values[2] = random_range(1, 2);
			values[2] -= values[2] % 0.1;
			values[5] = values[2];
			break;
			
		case MaxPaddlesMod:
			values[0] = irandom_range(3, 4);
			values[3] = values[0] == 4 ? "inf" : values[0];
			
			values[1] = irandom_range(1, 4);
			values[4] = values[1] == 4 ? "inf" : values[1];
			
			values[2] = irandom_range(1, 2);
			values[5] = values[2];
			break;
			
		case BrushSizeMod:
			values[0] = irandom_range(2, 3);
			values[3] = values[0];
			
			values[1] = irandom_range(1, 4);
			values[4] = values[1];
			
			values[2] = irandom_range(1, 4);
			values[5] = values[2];
			break;

		default:
			show_message("no functionality on set mod vals");
			break;
	}
	
	return values;
}

function set_game_setting(_mod, _vals, _diff)
{
	switch (_mod)
	{
		case BallEdgesMod:
			ball_edges = _vals[_diff];
			break;
			
		case GravityMod:
			gravity_scale = _vals[_diff];
			break;
		
		case BallSizeMod:
			ball_radius = _vals[_diff];
			break;
			
		case WallBounceMod:
			wall_bounce = _vals[_diff];
			break;
			
		case HitPowerMod:
			hit_power = _vals[_diff];
			break;
			
		case MaxPaddlesMod:
			max_paddles = _vals[_diff];
			break;
			
		case BrushSizeMod:
			brush_size = _vals[_diff];
			break;

		default:
			show_message("no functionality on set mod vals");
			break;
	}
}

if (useDebug)
{
	show_debug_overlay(1);
	if (!shaders_are_supported()) show_message("Shaders are not supported.");
	if (!shader_is_compiled(OnlyEdgesShader)) show_message($"The shader {shader_get_name(OnlyEdgesShader)} did not compile");
	if (!shader_is_compiled(OnlyEdgesShaderR8)) show_message($"The shader {shader_get_name(OnlyEdgesShaderR8)} did not compile");
}

#macro pixelstometerscale 0.1

physics_world_create(pixelstometerscale);
physics_world_update_speed(game_get_speed(gamespeed_fps) * 2);

application_surface_enable(1) // Enabled for FX
application_surface_draw_enable(0);
surface_depth_disable(true);

surf = INVALID;
surf_width = 320;
surf_height = 180;
grid = INVALID;

room_width = surf_width;
room_height = surf_height;

scale_surf_width = surf_width / view_get_wport(view_current);
scale_surf_height = surf_height / view_get_hport(view_current);

shake_intensity = 5;

enum GameState
{
	MainMenu, MainGame
}

LoadMenu(MainMenuLayer);

#macro player_bound_x1 40
#macro player_bound_y1 70
#macro player_bound_x2 120
#macro player_bound_y2 160
#macro zone_separator_e 0.75

function load_game()
{
	LoadMenu(LoadScreenLayer);
	alarm[2] = game_get_speed(gamespeed_fps) * 1;
}

function start_game()
{
	LoadMenu(InGameLayer);
	
	instance_create_depth(x, y, depth, PauseManager);
	
	global.gravity_y = gravity_scale * base_gravity;
	
	physics_world_gravity(global.gravity_x * pixelstometerscale, global.gravity_y * pixelstometerscale);
	
	fix = physics_fixture_create();
	physics_fixture_set_collision_group(fix, 1)
	physics_fixture_set_restitution(fix, wall_bounce);
	physics_fixture_set_edge_shape(fix, 0, 0, room_width, 0); // top
	physics_fixture_bind(fix, id);

	physics_fixture_set_edge_shape(fix, room_width, 0, room_width, room_height); // right
	physics_fixture_bind(fix, id);

	physics_fixture_set_edge_shape(fix, room_width, room_height, 0, room_height); // bottom
	physics_fixture_bind(fix, id);

	physics_fixture_set_edge_shape(fix, 0, room_height, 0, 0); // left
	physics_fixture_bind(fix, id);

	net_thickness = 2;
	net_height = surf_height / 3;

	instance_create_depth(room_width / 2, room_height - net_height / 2, depth - 1, Net, 
	{
		points_x: [[-net_thickness, net_thickness, net_thickness, -net_thickness]], 
		points_y: [[-net_height / 2, -net_height / 2, net_height / 2, net_height / 2]],
		point_count: 4,
		body_static: true
	});

	player = instance_create_depth(0, 0, depth - 1, Player, 
	{
		bounds_x1: player_bound_x1,
		bounds_y1: player_bound_y1,
		bounds_x2: player_bound_x2,
		bounds_y2: player_bound_y2,
		draw_area_side: tutorial ? sqrt((player_bound_x2 - player_bound_x1) * (player_bound_y2 - player_bound_y1) - 1) : 50,
		bounds_color: c_red,
		out_zone_color: c_blue
	});

	instance_create_depth(player_bound_x1, room_height, depth-10, PhysicsBody,
	{
		point_count: 4, 
		points_x: [[-4, 4, 4, -4]], 
		points_y: [[-12, -12, 12, 12]],
		point_mass: 1,
		body_static: true,
		e: zone_separator_e
	});

	instance_create_depth(player_bound_x2, room_height, depth-10, PhysicsBody,
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
		difficulty: tutorial ? 1 : enemy_difficulty / 11
	});

	instance_create_depth(room_width - player_bound_x2, room_height, depth-10, PhysicsBody,
	{
		point_count: 4, 
		points_x: [[-4, 4, 4, -4]], 
		points_y: [[-12, -12, 12, 12]],
		point_mass: 1,
		body_static: true,
		e: zone_separator_e
	});

	instance_create_depth(room_width - player_bound_x1, room_height, depth-10, PhysicsBody,
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
		point_count: ball_edges, 
		ball_radius: ball_radius,
		point_mass: 1
	});
	
	with (DrawnPlatformSpawner)
	{
		brush_size = other.brush_size;
	}

	audio_play_sound(snd_main_game, 0, true);
	
	var now = get_timer();
	start_second = now;
	
	var ui_root = layer_get_flexpanel_node(InGameLayer);
	var score_panel = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "ScorePanel"));
	var elementId = score_panel.layerElements[0].elementId;
	layer_text_text(elementId, $"{player.total_score} : {opponent.total_score}");
	
	if (tutorial) 
	{
		LoadMenu(TutorialLayer);
		random_set_seed(1); 
	}
	else
	{
		randomise();
	}
	
	reset_game();
}

function default_settings()
{
	enemy_difficulty = 6;
	ball_edges = 4;
	gravity_scale = 1;
	ball_radius = 15;
	wall_bounce = 0.75;
	hit_power = 1;
	max_paddles = 4;
	brush_size = 2;
	win_score = 11;
	endless = false;
	game_length = 3;
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
		
		if (GameManager.tutorial && TutorialManager.tutorial_state < TutorialState.PlayerDrawnLine)
		{
			phy_linear_velocity_x = 42.44;
			phy_linear_velocity_y = -80.56;
			phy_angular_velocity = 339.53
		}
		else
		{
			phy_linear_velocity_x = irandom(10) % 2 == 0 ? -random_range(45, 60) : random_range(45, 60); // 45, 60
			phy_linear_velocity_y = random_range(-80, -35); // -35, -80
			phy_angular_velocity = irandom_range(-1500, 1500);
		}
	}
	
	with (DrawnPlatformSpawner)
	{
		spawner_mode = SpawnerMode.ChangeSize;
		paddles = 0;
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
	//fx_set_parameter(PauseManager.game_blur, "g_intensity", 0);
	physics_remove_fixture(id, fix);
	physics_pause_enable(true);
	instance_activate_all();
	
	if (_target_menu == EndScreenLayer)
	{
		var ui_root = layer_get_flexpanel_node(EndScreenLayer);
		var setting, elementId;
		setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "ScoreText"));
		elementId = setting.layerElements[0].elementId;
		layer_text_text(elementId, $"{player.total_score} : {opponent.total_score}");
		
		setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "TimeText"));
		elementId = setting.layerElements[0].elementId;
		layer_text_text(elementId, $"{opponent.total_score > player.total_score ? "Lost" : (player.total_score > opponent.total_score ? "Won" : "Drew")} in {PadWithZeroes(floor(PauseManager.total_time) div 60, 2)}m : {PadWithZeroes(floor(PauseManager.total_time) mod 60, 2)}s");
		
		setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "AIIcon"));
		elementId = setting.layerElements[0].elementId;
		layer_sprite_index(elementId, opponent.total_score > player.total_score ? 0 : 1);
		
		LoadMenu(EndScreenLayer);
	}
	else 
	{
		GameManager.default_settings(); 
		LoadMenu(LoadScreenLayer);
		alarm[_target_menu == MainMenuLayer ? 3 : 4] =  game_get_speed(gamespeed_fps) * 1;;
	}
	
	with (all)
	{
		if (!persistent) { instance_destroy(); }
	}
}

function set_game_setting_page(_page)
{
	var ui_root = layer_get_flexpanel_node(PlayMenuLayer);
	var pages = flexpanel_node_get_child(ui_root, "GameSettingsPages");
	var max_pages = flexpanel_node_get_num_children(pages);
	var max_page_index = max_pages - 1;
	
	GameManager.game_settings_page = clamp(_page, 0, max_page_index);
	
	var settings_title = flexpanel_node_get_child(ui_root, "GameSettingsPanel");
	layer_text_text(flexpanel_node_get_struct(settings_title).layerElements[0].elementId, 
		$"Game Settings  ({GameManager.game_settings_page + 1}/{max_pages})")
	
	var pages_left_pos = max_page_index * 200 - GameManager.game_settings_page * 400;
	
	flexpanel_node_style_set_position(pages, flexpanel_edge.left, pages_left_pos, flexpanel_unit.point);
}

function set_challenge_page(_page)
{
	var ui_root = layer_get_flexpanel_node(PlayMenuLayer);
	var pages = flexpanel_node_get_child(ui_root, "ChallengePages");
	var max_pages = flexpanel_node_get_num_children(pages);
	var max_page_index = max_pages - 1;
	
	GameManager.challenge_page = clamp(_page, 0, max_page_index);
	
	var levels = ["Easy", "Medium", "Hard"];
	
	var challenge_title = flexpanel_node_get_child(ui_root, "ChallengeLevelTitlePanel");
	layer_text_text(flexpanel_node_get_struct(challenge_title).layerElements[0].elementId, 
		$"Level: {levels[GameManager.challenge_page]}")
	
	var pages_left_pos = max_page_index * 200 - GameManager.challenge_page * 400;
	
	flexpanel_node_style_set_position(pages, flexpanel_edge.left, pages_left_pos, flexpanel_unit.point);
}