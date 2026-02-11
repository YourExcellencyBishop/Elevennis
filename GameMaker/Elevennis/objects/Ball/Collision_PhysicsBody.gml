with (AI)
{
	found_place = false;
}

GameManager.shake_intensity = lerp(1, 2, phy_speed/5);

audio_play_sound(snd_collision_physics_body, 2, false);