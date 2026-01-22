var s = 20;

draw_sprite_ext(custom_spr, 0, 0, 0, s, s, 0, c_white, 1);

draw_set_colour(c_red)
for (var i = 0; i < point_count; i++)
{
	draw_line(s*points[i][0], s*points[i][1], s*points[(i + 1) % point_count][0], s*points[(i + 1) % point_count][1]);
	draw_circle(s*points[i][0], s*points[i][1], 5, false);
}
draw_set_colour(c_white)