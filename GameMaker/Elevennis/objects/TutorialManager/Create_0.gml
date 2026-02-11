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
	PlayerDrawLine
}

ui_root = layer_get_flexpanel_node(TutorialLayer);

var tutorial_text = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "TutorialText"));
tutorial_text_Id = tutorial_text.layerElements[0].elementId;

var start_tutorial_button = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "StartGameButton"));
start_tutorial_button_Id = start_tutorial_button.layerElements[0].elementId;

with (start_tutorial_button_Id)
{
	active = false;
	image_alpha = 0;
}

var start_tutorial_text = flexpanel_node_get_struct(flexpanel_node_get_child(ui_root, "StartGameText"));
start_tutorial_text_Id = start_tutorial_text.layerElements[0].elementId;
layer_text_alpha(start_tutorial_text_Id, 0);


tutorial_state = TutorialState.WelcomeMessage;
layer_text_text(tutorial_text_Id, "Welcome To Elevenis");

/*

Welcome: 
Welcome To Elevenis

---

Goal:
In this game you must defend
your area by drawing paddles to
block the ball

*/