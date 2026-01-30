//draw_set_colour(c_blue);
//draw_rectangle(x, y, x + sprite_width, y + sprite_height, false);
//draw_set_colour(c_white);

if (mode == 0)
{
	draw_set_colour(c_red)
	if(cyclic)
	{
		for (var i = 0; i < point_count; i++)
		{
			var lx1 = points_x[i], ly1 = points_y[i];
			var lx2 = points_x[(i + 1) % point_count], ly2 = points_y[(i + 1) % point_count];

			draw_line(x + lx1, y + ly1, x + lx2, y + ly2);
			//draw_circle(x + s*points_x[i], y + s*points_y[i], 5, false);
		}
	}
	else
	{
		for (var i = 0; i < point_count - 1; i++)
		{
			draw_line(points_x[i], points_y[i], points_x[i + 1], points_y[i + 1]);
			//draw_circle(points_x[i], points_y[i], 5, false);
		}
		//draw_circle(s*points_x[point_count - 1], s*points_y[point_count - 1], 5, false);
	}
	draw_set_colour(c_white)
}

if (mode == 1)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);