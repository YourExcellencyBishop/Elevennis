var s = 1;

draw_set_colour(c_red)
if(cyclic)
{
	for (var i = 0; i < point_count; i++)
	{
		draw_line(s*points_x[i], s*points_y[i], s*points_x[(i + 1) % point_count], s*points_y[(i + 1) % point_count]);
		draw_circle(s*points_x[i], s*points_y[i], 5, false);
	}
}
else
{
	for (var i = 0; i < point_count - 1; i++)
	{
		draw_line(s*points_x[i], s*points_y[i], s*points_x[i + 1], s*points_y[i + 1]);
		draw_circle(s*points_x[i], s*points_y[i], 5, false);
	}
	draw_circle(s*points_x[point_count - 1], s*points_y[point_count - 1], 5, false);
}
draw_set_colour(c_white)

draw_sprite(sprite_index, 0, x, y);