// Inherit the parent event
point_list_count = array_length(points_x);

if (point_count != 9)
{
	points_x = [array_create(point_count, INVALID)];
	points_y = [array_create(point_count, INVALID)];

	for (var i = 0, angle = 0, angle_incr = 360 / point_count; i < point_count; i++)
	{
		points_x[0][i] = dcos(angle) * 15;
		points_y[0][i] = dsin(angle) * 15;
	
		angle += angle_incr;
	}
}
else
{
	points_x = [[ball_radius]];
	body_type = PhysicsBodyType.Circle;
	show_message("Ball")
}

event_inherited();