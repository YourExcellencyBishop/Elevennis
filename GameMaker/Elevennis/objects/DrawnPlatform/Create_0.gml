point_list_count = array_length(points_x);

if (point_count == INVALID)
{
	var point_count_x = 0;
	var point_count_y = 0;
	
	for (var i = 0; i < point_list_count; i++)
	{
		point_count_x += array_length(points_x[i]);
		point_count_y += array_length(points_y[i]);
	}
	
	if ((point_count_x == 0 || point_count_y == 0) || point_count_x != point_count_y)
	{
		throw "Yh no physics here buddy";
	}
	
	point_count = point_count_x;
}

// show_debug_message($"Set number of points: {point_count} points")

var _top = infinity, _left = infinity;
centre_of_mass_x = 0;
centre_of_mass_y = 0;
total_mass = 0;

for (var i = 0; i < point_list_count; i++)
{
	var point_list_length = array_length(points_x[i]);
	for (var j = 0; j < point_list_length; j++)
	{
		centre_of_mass_x += points_x[i][j] * point_mass;
		centre_of_mass_y += points_y[i][j] * point_mass;
		total_mass += point_mass;
	}
}

centre_of_mass_x /= total_mass;
centre_of_mass_y /= total_mass;

for (var i = 0; i < point_list_count; i++)
{
	var point_list_length = array_length(points_x[i]);
	for (var j = 0; j < point_list_length; j++)
	{
		points_x[i][j] -= centre_of_mass_x;
		points_y[i][j] -= centre_of_mass_y;
		
		_left = min(floor(points_x[i][j]), _left);
		_top = min(floor(points_y[i][j]), _top);
	}
}

if (sprite_index != -1)
{
	sprite_set_offset(sprite_index, -_left, -_top);
	x += -_left;
	y += -_top;
}

event_inherited();

#macro max_power (5 * GameManager.hit_power)
#macro min_power (0.5 * GameManager.hit_power)

swing = lerp(min_power, max_power, 1 - min(1, surface_area / 100));
color = make_colour_rgb(255 * swing / max_power, 255 * (1 - swing / max_power), 1);
alarm[0] = 1;

if (point_count == 0) throw "No points";

// show_debug_message($"Surface Area of {surface_area}");