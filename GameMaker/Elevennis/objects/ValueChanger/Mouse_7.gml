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
		
	case ValueID.None:
	default:
		show_debug_message("No Functionality Assigned!");
		break;
}