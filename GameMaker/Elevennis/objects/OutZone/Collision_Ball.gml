collision = other;

if (func != INVALID) func();

with (GameManager)
{
	var ui_root = layer_get_flexpanel_node(InGameLayer);
	var score_panel = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "ScorePanel"));
	var elementId = score_panel.layerElements[0].elementId;
	layer_text_text(elementId, $"{player.total_score} : {opponent.total_score}");
}