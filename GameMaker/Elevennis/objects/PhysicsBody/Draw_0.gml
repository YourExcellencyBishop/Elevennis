point_count = array_length(points);

var s = 30;

for (var i = 0; i < point_count; i++)
{
	//draw_line(points[i][0], points[i][1], points[(i + 1) % point_count][0], points[(i + 1) % point_count][1]);
	//draw_circle(points[i][0], points[i][1], 5, false);
	
	//draw_line(s*points[i][0], s*points[i][1], s*points[(i + 1) % point_count][0], s*points[(i + 1) % point_count][1]);
	//draw_circle(s*points[i][0], s*points[i][1], 5, false);
}

draw_sprite_ext(custom_spr, 0, x, y, 30, 30, 0, c_white, 1);