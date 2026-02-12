if (tutorial_state >= TutorialState.DrawPaddleMessage && tutorial_state <= TutorialState.PlayerDrawnLine)
{
	draw_line(88, 75, 110, 110);
	draw_circle(TutorialManager.first_paddle_x1, TutorialManager.first_paddle_y1, GameManager.player.platform_spawner.brush_size, true);
	draw_set_colour(c_red);
	draw_circle(lerp(first_paddle_x1, first_paddle_x2, sqr((current_time % 1000) / 1000)), 
		lerp(first_paddle_y1, first_paddle_y2, sqr((current_time % 1000) / 1000)), GameManager.player.platform_spawner.brush_size + 2, false);
	draw_set_colour(c_white)
}