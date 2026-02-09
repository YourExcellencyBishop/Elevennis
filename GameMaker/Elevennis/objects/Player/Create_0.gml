// Inherit the parent event
event_inherited();

out_of_play_1 = MakeBoxSensor(0, room_height - 3, bounds_x1, room_height, OutZone, depth);
out_of_play_1.color = c_yellow;
out_of_play_1.character = id;
out_of_play_1.func = function()
{
	with(other.collision)
	{
		if (last_touch != INVALID) { last_touch.enemy.total_score++; }
		
		if (!GameManager.endless && last_touch.enemy.total_score == GameManager.win_score)
		{
			GameManager.end_game(EndScreenLayer);
			return;
		}
	}
	
	with (GameManager)
	{
		reset_game();
	}
}

out_of_play_2 = MakeBoxSensor(bounds_x2, room_height - 3, room_width / 2 - GameManager.net_thickness, room_height, OutZone, depth);
out_of_play_2.color = c_yellow;
out_of_play_2.character = id;
out_of_play_2.func = out_of_play_1.func;