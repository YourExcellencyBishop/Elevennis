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

if (array_length(point_mass) == 0)
{
	point_mass = array_create(point_count, 1);
} 

var top = infinity, left = infinity;
centre_of_mass_x = 0;
centre_of_mass_y = 0;
total_mass = 0;
inertia = 0;

for (var i = 0; i < point_count; i++)
{
	centre_of_mass_x += points_x[i] * point_mass[i];
	centre_of_mass_y += points_y[i] * point_mass[i];
	total_mass += point_mass[i];
}

centre_of_mass_x /= total_mass;
centre_of_mass_y /= total_mass;

for (var i = 0; i < point_count; i++)
{
	points_x[i] -= centre_of_mass_x;
	points_y[i] -= centre_of_mass_y;
	
	left = min(floor(points_x[i]), left);
	top = min(floor(points_y[i]), top);
	
	inertia += (points_x[i] * points_x[i] + points_y[i] * points_y[i]) * point_mass[i];
}

centre_of_mass_x = 0;
centre_of_mass_y = 0;

sprite_set_offset(sprite_index, -left, -top);
x += -left;
y += -top;

image_angle = 0;
vx = 0;
vy = 0;
omega = 0;

fx = 0;
fy = 0;
torque = 0;

show_debug_message($"{point_count} points")