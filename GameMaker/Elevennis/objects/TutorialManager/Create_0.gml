enum TutorialState
{
	None, 
	WelcomeMessage, 
	GoalOfTheGameMessage,
	AIGoesFirstMessage,
	GameStart,
	AIIsReady,
	PlayerIsReady,
	BeginTutorialGame,
	ExplainPaddle1,
	ExplainPaddle2,
	BallReturnsMessage,
	BallReturns,
	DrawPaddleMessage,
	PlayerDrawnLine,
	PlayerFirstAttack,
	FirstPoint,
	DrawAreaMessage,
	YellowZone,
	WinRule,
	LeaveTutorial,
	EndTutorial,
	Finished
}

ui_root = layer_get_flexpanel_node(TutorialLayer);
ingame_ui_root = layer_get_flexpanel_node(InGameTutorialLayer);
ingame_game_ui_root = layer_get_flexpanel_node(InGameLayer);

var tutorial_text = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "TutorialText"));
tutorial_text_Id = tutorial_text.layerElements[0].elementId;

var start_tutorial_button = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "StartGameButton"));
start_tutorial_button_Id = start_tutorial_button.layerElements[0].instanceId;

with (start_tutorial_button_Id)
{
	active = false;
	image_alpha = 0;
}

var pause_button = flexpanel_node_get_struct(flexpanel_node_get_child(ingame_game_ui_root, "PauseButton"));
pause_button_Id = pause_button.layerElements[0].instanceId;

with (pause_button_Id)
{
	active = false;
	image_alpha = 0;
}

var start_tutorial_text = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "StartGameText"));
start_tutorial_text_Id = start_tutorial_text.layerElements[0].elementId;
layer_text_alpha(start_tutorial_text_Id, 0);

var ingame_tutorial_text = flexpanel_node_get_struct(flexpanel_node_get_child(ingame_ui_root, "Text"));
ingame_tutorial_text_id = ingame_tutorial_text.layerElements[0].elementId;


tutorial_state = TutorialState.WelcomeMessage;
layer_text_text(tutorial_text_Id, "Welcome To Elevennis");

first_paddle_x1 = 88;
first_paddle_y1 = 75;
first_paddle_x2 = 110;
first_paddle_y2 = 110;

drawn_first_paddle = false;