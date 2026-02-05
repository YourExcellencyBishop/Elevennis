draw_set_font(ScoreFont);

draw_set_halign(fa_center);
draw_text(display_get_gui_width() / 2, 0, $"{player.total_score} : {opponent.total_score}");