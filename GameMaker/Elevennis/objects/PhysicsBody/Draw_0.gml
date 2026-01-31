var cosA = cos(degtorad(-image_angle));
var sinA = sin(degtorad(-image_angle));
		
for (var i = 0; i < point_count; i++)
{
	var lx1 = points_x[i], ly1 = points_y[i];
	var lx2 = points_x[(i + 1) % point_count], ly2 = points_y[(i + 1) % point_count];
			
	var px1 = cosA * lx1 - sinA * ly1;
	var py1 = sinA * lx1 + cosA * ly1;
			
	var px2 = cosA * lx2 - sinA * ly2;
	var py2 = sinA * lx2 + cosA * ly2;

	draw_line(x + px1, y + py1, x + px2, y + py2);
	//draw_circle(x + s*points_x[i], y + s*points_y[i], 5, false);
}