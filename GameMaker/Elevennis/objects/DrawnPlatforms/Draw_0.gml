//draw_set_colour(c_blue);
//draw_rectangle(x, y, x + sprite_width, y + sprite_height, false);
//draw_set_colour(c_white);

if (mode == 0)
{
	var s = 1;

	draw_set_colour(c_red)
	if(cyclic)
	{
		for (var i = 0; i < point_count; i++)
		{
			draw_line(x + s*points_x[i], y + s*points_y[i], x + s*points_x[(i + 1) % point_count], y + s*points_y[(i + 1) % point_count]);
			//draw_circle(x + s*points_x[i], y + s*points_y[i], 5, false);
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
}

if (mode == 1)
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, rotation, c_white, 1);
	
draw_set_colour(c_red);
draw_rectangle(x + centre_of_mass_x - 1, y + centre_of_mass_y - 1, 
	x + centre_of_mass_x + 1, y + centre_of_mass_y + 1, false);
draw_set_colour(c_white);

draw_set_colour(c_blue);
draw_rectangle(x - sprite_xoffset - 1, y - sprite_yoffset - 1, 
	x - sprite_xoffset + 1, y - sprite_yoffset + 1, false);
draw_set_colour(c_white);

draw_set_colour(c_purple);
draw_rectangle(x - 1, y - 1, 
	x + 1, y + 1, false);
draw_set_colour(c_white);