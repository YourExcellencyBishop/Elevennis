var s = 5;

draw_sprite_ext(sprite_index, 0, x + 160, y + 90, s, s, 0, c_white, 1);

draw_set_colour(c_green);

for (var k = 0, j = 0; k < point_count; k++)
{
	j = (k + 1) % point_count;
	
	draw_line(points_x[k]*s + 160, points_y[k]*s + 90, points_x[j]*s + 160, points_y[j]*s + 90);
}


draw_set_colour(c_red);

var j = (ii + 1) % point_count;
draw_line(points_x[ii]*s + 160, points_y[ii]*s + 90, points_x[j]*s + 160, points_y[j]*s + 90);

draw_set_colour(c_white);