if (mouse_check_button_pressed(mb_left))
{
	switch (tutorial_state)
	{
		case TutorialState.WelcomeMessage:
			tutorial_state = TutorialState.GoalOfTheGameMessage;
			layer_text_text(tutorial_text_Id, "In this game you must defend\nyour area by drawing paddles to\nblock the ball");
			break;
			
		case TutorialState.GoalOfTheGameMessage:
			tutorial_state = TutorialState.AIGoesFirstMessage;
			layer_text_text(tutorial_text_Id, "For the sake of this tutorial,\nthe opponent will start");
			
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
			show_debug_message("In this game, the longer the paddle draw, the weaker the hit. A smaller paddle will hit move the ball further.")
			tutorial_state = TutorialState.BallReturnsMessage;
			break;
			
		case TutorialState.BallReturnsMessage:
			show_debug_message("Get ready for the ball to return")
			tutorial_state = TutorialState.BallReturns;
			break;
			
		case TutorialState.BallReturns:
			physics_pause_enable(false);
			instance_destroy(destroy_instance);
			break;
			
		case TutorialState.DrawPaddleMessage:
			show_debug_message("Follow the line and draw a paddle");
			break;
			
		case TutorialState.DrawAreaMessage:
			show_debug_message("Here is your draw area, you can move it about to change where you want to draw");
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
			show_debug_message("The yellow area is an illegal zone. Whoever hit it last will forfeit the point");
			tutorial_state = TutorialState.EndTutorial;
			break;
			
		case TutorialState.EndTutorial:
			show_debug_message("The tutorial will end when you or your opponent get to 11 to the time runs out. Good Luck!");
			GameManager.endless = false
			GameManager.win_score = 3;
			GameManager.opponent.draw_delay = 0;
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
		show_debug_message("The opponent Is Ready. Click ready to begin");
			
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
		show_debug_message("The opponent has drawn a paddle")
		if (mouse_check_button_pressed(mb_left)) { tutorial_state = TutorialState.ExplainPaddle2; }
		break;
		
	case TutorialState.BallReturns:
		if (GameManager.ball.phy_position_x < room_width / 2)
		{
			physics_pause_enable(true);
			show_debug_message("Now you must draw a paddle to defend your court");
			tutorial_state = TutorialState.DrawPaddleMessage
		}
		break;
		
	case TutorialState.PlayerDrawnLine:
		show_debug_message("Release");
		
		if (!mouse_check_button(mb_left))
		{
			physics_pause_enable(false);
			GameManager.opponent.draw_delay = infinity;
			tutorial_state = TutorialState.PlayerFirstAttack;
		}
		break;
		
	case TutorialState.FirstPoint:
		show_debug_message("You won a point");
		tutorial_state = TutorialState.DrawAreaMessage;
		break;
}