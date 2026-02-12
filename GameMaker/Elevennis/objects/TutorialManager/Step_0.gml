if (mouse_check_button_pressed(mb_left))
{
	switch (tutorial_state)
	{
		case TutorialState.WelcomeMessage:
			tutorial_state = TutorialState.GoalOfTheGameMessage;
			layer_text_text(tutorial_text_Id, "Defend your side\nby drawing paddles to block the ball.");
			break;
			
		case TutorialState.GoalOfTheGameMessage:
			tutorial_state = TutorialState.AIGoesFirstMessage;
			layer_text_text(tutorial_text_Id, "For this tutorial,\nyour opponent will go first.");
			
			layer_text_alpha(start_tutorial_text_Id, 1);
			with (start_tutorial_button_Id)
			{
				active = true;
				image_alpha = 1;
			}
			break;
			
		case TutorialState.AIGoesFirstMessage:
			tutorial_state = TutorialState.GameStart;
			layer_set_visible(TutorialLayer, false);
			GameManager.opponent.alarm[1] = game_get_speed(gamespeed_fps) * 2;
			break;
			
		case TutorialState.ExplainPaddle2:
			//tutorial_state = TutorialState.BallReturnsMessage;
			break;
			
		case TutorialState.BallReturnsMessage:
			layer_text_text(ingame_tutorial_text_id, "Get ready - the ball is coming back.");
			tutorial_state = TutorialState.BallReturns;
			break;
			
		case TutorialState.BallReturns:
			physics_pause_enable(false);
			instance_destroy(destroy_instance);
			break;
			
		case TutorialState.DrawPaddleMessage:
			layer_text_text(ingame_tutorial_text_id, "Follow the guide line and draw a paddle with your mouse.");
			break;
			
		case TutorialState.DrawAreaMessage:
			layer_text_text(ingame_tutorial_text_id, "This is your draw area.\nYou can move it later to change where you draw.\n(AFTER THESE MESSAGES)");
			with (GameManager.player.platform_spawner)
			{
				draw_area_side = 50;
				
				draw_area_size = draw_area_side*draw_area_side;

				draw_area_x1 = bounds_centre_x - draw_area_side * 0.5;
				draw_area_x2 = bounds_centre_x + draw_area_side * 0.5;
				draw_area_y1 = bounds_centre_y - draw_area_side * 0.5;
				draw_area_y2 = bounds_centre_y + draw_area_side * 0.5;
				
				min_draw_area_width = draw_area_size / bounds_height;
				min_draw_area_height = draw_area_size / bounds_width;
			}
			tutorial_state = TutorialState.YellowZone;
			break;
			
		case TutorialState.YellowZone:
			layer_text_text(ingame_tutorial_text_id, "The yellow zone is illegal. Whoever hits it last loses the point.");
			tutorial_state = TutorialState.WinRule;
			break;
			
		case TutorialState.WinRule:
			layer_text_text(ingame_tutorial_text_id, "The tutorial ends when someone reaches 11 points\nor time runs out.");
			PauseManager.start_time = 0;
			PauseManager.total_time = 0;
			GameManager.endless = false;
			GameManager.win_score = 11;
			tutorial_state = TutorialState.LeaveTutorial;
			break;
			
		case TutorialState.LeaveTutorial:
			layer_text_text(ingame_tutorial_text_id, "Press Esc or click the pause icon to leave the tutorial.");
			
			with (pause_button_Id)
			{
				active = true;
				image_alpha = 1;
			}

			tutorial_state = TutorialState.EndTutorial;
			break
		
		case TutorialState.EndTutorial:
			layer_text_text(ingame_tutorial_text_id, "Good Luck!");
			tutorial_state = TutorialState.Finished;
			break;
		
		case TutorialState.Finished:
			layer_set_visible(InGameTutorialLayer, false);
			GameManager.opponent.draw_delay = 0;
			GameManager.opponent.difficulty = 3/11;
			tutorial_state = TutorialState.Finished;
			break;
		
		default:
			break;
	}
}

switch (tutorial_state)
{
	case TutorialState.GameStart:
		if (GameManager.opponent.ready_to_play)
		{
			tutorial_state = TutorialState.AIIsReady;
		}
		break;
			
	case TutorialState.AIIsReady:
		layer_text_text(ingame_tutorial_text_id, "The opponent Is ready.\nClick \"Ready?\" to begin")
		layer_set_visible(InGameTutorialLayer, true);
			
		if (GameManager.player.ready_to_play)
		{
			tutorial_state = TutorialState.PlayerIsReady;
		}
		break;
		
	case TutorialState.PlayerIsReady:	
		if (PauseManager.ready_to_play)
		{
			tutorial_state = TutorialState.BeginTutorialGame;
			show_debug_message("Beginning Tutorial Game");
		}
		break;
		
	case TutorialState.ExplainPaddle1:
		layer_text_text(ingame_tutorial_text_id, "The opponent has drawn a paddle.");
		if (mouse_check_button_pressed(mb_left)) 
		{ 
			tutorial_state = TutorialState.BallReturnsMessage; 
			layer_text_text(ingame_tutorial_text_id, "Longer paddles = weaker hits.\nShorter paddles = stronger hits.");
		}
		break;
		
	case TutorialState.BallReturns:
		if (GameManager.ball.phy_position_x < room_width / 2)
		{
			physics_pause_enable(true);
			layer_text_text(ingame_tutorial_text_id, "Now you must draw a paddle to defend your court");
			tutorial_state = TutorialState.DrawPaddleMessage
		}
		break;
		
	case TutorialState.PlayerDrawnLine:
		layer_text_text(ingame_tutorial_text_id, "RELEASE!");
		
		if (!mouse_check_button(mb_left))
		{
			physics_pause_enable(false);
			GameManager.opponent.draw_delay = infinity;
			tutorial_state = TutorialState.PlayerFirstAttack;
			layer_set_visible(InGameTutorialLayer, false);
		}
		break;
		
	case TutorialState.FirstPoint:
		layer_text_text(ingame_tutorial_text_id, "You won a point");
		layer_set_visible(InGameTutorialLayer, true);
		tutorial_state = TutorialState.DrawAreaMessage;
		break;
}