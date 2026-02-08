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
			//layer_text_halign(elementId, textalign_center);
		}
		break;
		
	case ValueID.None:
	default:
		show_debug_message("No Functionality Assigned!");
		break;
}