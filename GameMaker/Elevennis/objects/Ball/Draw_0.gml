draw_set_colour(image_blend);
event_inherited();
draw_set_colour(c_white);

if (!PauseManager.ready_to_play)
{
	draw_set_colour(c_yellow);
	draw_arrow(phy_position_x, phy_position_y, phy_position_x + (phy_speed_x / phy_speed ) * 30, phy_position_y + (phy_speed_y /  phy_speed) * 30, 10);
	draw_set_colour(c_white);
}