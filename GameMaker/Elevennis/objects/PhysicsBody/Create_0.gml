if (point_count == -1)
{
	var point_count_x = array_length(points_x);
	var point_count_y = array_length(points_y);
	
	if ((point_count_x == 0 || point_count_y == 0) || point_count_x != point_count_y)
	{
		throw "Yh no physics here buddy";
	}
	
	point_count = point_count_x;
}

var top = infinity, left = infinity;

for (var i = 0; i < point_count; i++)
{
	centre_of_mass_x += points_x[i];
	centre_of_mass_y += points_y[i];
}

centre_of_mass_x /= point_count;
centre_of_mass_y /= point_count;

for (var i = 0; i < point_count; i++)
{
	points_x[i] -= centre_of_mass_x;
	points_y[i] -= centre_of_mass_y;
	
	left = min(floor(points_x[i]), left);
	top = min(floor(points_y[i]), top);
}

sprite_set_offset(sprite_index, -left, -top);

x += -left;
y += -top;
centre_of_mass_x = 0;
centre_of_mass_y = 0;

rotation = 0;