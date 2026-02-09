var ui_root = layer_get_flexpanel_node(PlayMenuLayer);
var setting, elementId;

switch (value_id)
{
	case ValueID.EnemyDifficulty:
		if (GameManager.page == 0)
		{
			GameManager.enemy_difficulty = clamp(GameManager.enemy_difficulty + (increments ? 1 : -1), 1, 11);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "EnemyDifficulty"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.enemy_difficulty}/11");
		}
		break;
		
	case ValueID.BallEdges:
		if (GameManager.page == 0)
		{
			GameManager.ball_edges = clamp(GameManager.ball_edges + (increments ? 1 : -1), 3, 9);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "BallEdges"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.ball_edges == 9 ? "inf": GameManager.ball_edges}");
		}
		break;
	
	case ValueID.Gravity:
		if (GameManager.page == 0)
		{
			GameManager.gravity_scale = clamp(GameManager.gravity_scale + (increments ? 0.1 : -0.1), 0.5, 1.5);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Gravity"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{string_format(GameManager.gravity_scale, 1, 1)}x");
		}
		break;
		
	case ValueID.BallRadius:
		if (GameManager.page == 0)
		{
			GameManager.ball_radius = clamp(GameManager.ball_radius + (increments ? 1 : -1), 5, 20);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "BallRadius"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.ball_radius}");
		}
		break;
		
	case ValueID.WallBounce:
		if (GameManager.page == 1)
		{
			GameManager.wall_bounce = clamp(GameManager.wall_bounce + (increments ? 0.05 : -0.05), 0.25, 1.5);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "WallBounce"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.wall_bounce}");
		}
		break;
		
	case ValueID.HitPower:
		if (GameManager.page == 1)
		{
			GameManager.hit_power = clamp(GameManager.hit_power + (increments ? 0.1 : -0.1), 1, 2);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "HitPower"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{string_format(GameManager.hit_power, 1, 1)}");
		}
		break;
		
	case ValueID.MaxPaddles:
		if (GameManager.page == 1)
		{
			GameManager.max_paddles = clamp(GameManager.max_paddles + (increments ? 1 : -1), 1, 4);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "MaxPaddles"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.max_paddles == 4 ? "inf" : GameManager.max_paddles}");
		}
		break;
		
	case ValueID.BrushSize:
		if (GameManager.page == 1)
		{
			GameManager.brush_size = clamp(GameManager.brush_size + (increments ? 1 : -1), 1, 4);
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "BrushSize"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.brush_size}");
		}
		break;
		
	case ValueID.WinScore:
		if (GameManager.page == 2)
		{
			GameManager.win_score = clamp(GameManager.win_score + (increments ? 1 : -1), 1, 100);
			if (GameManager.endless)
			{
				GameManager.win_score = 11;
				GameManager.game_length = 3;
				GameManager.endless = false;
			}
			
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "WinScore"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.win_score}");
			
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Time"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.game_length}");
			
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Endless"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, "OFF");
		}
		break;
		
	case ValueID.Endless:
		if (GameManager.page == 2)
		{
			GameManager.endless = !GameManager.endless;
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Endless"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			
			GameManager.win_score = 11;
			var win_score_setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "WinScore"));
			var win_score_elementId = win_score_setting.nodes[2].layerElements[0].elementId;
			
			GameManager.game_length = 3;
			var game_length_setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Time"));
			var game_length_elementId = game_length_setting.nodes[2].layerElements[0].elementId;
			
			if (GameManager.endless)
			{
				layer_text_text(elementId, "ON");
				layer_text_text(win_score_elementId, "inf");
				layer_text_text(game_length_elementId, "inf");
			}
			else
			{
				layer_text_text(elementId, "OFF");
				layer_text_text(win_score_elementId, $"{GameManager.win_score}");
				layer_text_text(game_length_elementId, $"{GameManager.game_length}");
			}
		}
		break;
		
	case ValueID.Time:
		if (GameManager.page == 2)
		{
			GameManager.game_length = clamp(GameManager.game_length + (increments ? 1 : -1), 1, 100);
			if (GameManager.endless) 
			{
				GameManager.game_length = 3;
				GameManager.win_score = 11;
				GameManager.endless = false;
			}
			
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Time"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.game_length}");
			
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "WinScore"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, $"{GameManager.win_score}");
			
			setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "Endless"));
			elementId = setting.nodes[2].layerElements[0].elementId;
			layer_text_text(elementId, "OFF");
		}
		break;
		
	case ValueID.None:
	default:
		show_debug_message("No Functionality Assigned!");
		break;
}