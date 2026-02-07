var ui_root = layer_get_flexpanel_node(PlayMenuLayer);
var setting, elementId;

switch (value_id)
{
	case ValueID.EnemyDifficulty:
		GameManager.enemy_difficulty = clamp(GameManager.enemy_difficulty + (increments ? 1 : -1), 1, 11);
		setting = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "EnemyDifficulty"));
		elementId = setting.nodes[2].layerElements[0].elementId;
		layer_text_text(elementId, $"{GameManager.enemy_difficulty}/11");
		break;
		
	case ValueID.None:
		break;
}