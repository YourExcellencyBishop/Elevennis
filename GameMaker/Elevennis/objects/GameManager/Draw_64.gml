if (!layer_get_visible(InGameLayer) || layer_get_visible(TutorialLayer)) { draw_sprite_ext(PencilIcon, 0, mouse_x, mouse_y, 1/scale_surf_width, 1/scale_surf_height, icon_rot, c_white, 1); }

if (layer_get_visible(CreditsLayer))
{
	// ---- setup ----
	draw_set_font(InGameFont);
	draw_set_valign(fa_top);
	draw_set_halign(fa_center);

	var alpha = audio_exists(credits_intro_sound)
		? audio_sound_get_track_position(credits_intro_sound) / audio_sound_length(credits_intro_sound)
		: 1;
	draw_set_alpha(alpha);

	var gui_w = display_get_gui_width();
	var gui_h = display_get_gui_height();
	var xx    = gui_w * 0.5;
	var dt    = delta_time / 1000000;

	// ---- draw & animate items ----
	for (var i = 0; i < 3; i++)
	{
		var item = credits_items[i];
		var _y    = credits_y[i];

		draw_text_ext_transformed(xx, _y, item, -1, -1, 10, 10, 0);
	}

	draw_set_alpha(1);

	// ---- scrolling ----
	if (audio_is_playing(snd_credits))
	{
		var disp = dt * 80;
		for (var i = 0; i < 3; i++)
		{
			credits_y[i] -= disp;
		}
	}

	// ---- recycle off-screen items (order preserved) ----
	for (var i = 0; i < 3; i++)
	{
		var item   = credits_items[i];
		var height = string_height(item) * 10;

		if (credits_y[i] + height < 0)
		{

			credits_items[i] = all_credits_items[credits_item++];
			credits_item %= array_length(all_credits_items);

			var prev = (i + 2) % 3; // same dependency as original code
			var prev_item   = credits_items[prev];
			var prev_height = string_height(prev_item) * 10;

			credits_y[i] = GameManager.credits_y[prev] + prev_height + gui_h / 3;
		}
	}
	
	draw_set_font(MenuFont);
	draw_set_valign(fa_bottom);
	draw_set_colour(c_yellow);
	draw_text(xx, gui_h, $"(Click {credits_clicks} times to Leave Credits)");
	draw_set_colour(c_white);
}

