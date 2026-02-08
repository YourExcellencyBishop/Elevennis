with (AI)
{
	found_place = false;
}

if (phy_collision_x < 5)
{
	audio_play_sound(snd_collision_left, 2, false, 1, 0, 0.75);
	show_debug_message("L")
}
else if (phy_collision_x > room_width - 5)
{
	audio_play_sound(snd_collision_right, 2, false, 1, 0, 0.75);
	show_debug_message("R")
}
else
{
	audio_play_sound(snd_collision, 2, false, 1, 0, 0.75);
}