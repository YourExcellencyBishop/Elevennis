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

show_debug_message($"{point_count} points")

if (array_length(point_mass) == 0)
{
	point_mass = array_create(point_count, 1);
} 

var _top = infinity, _left = infinity;
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
	
	_left = min(floor(points_x[i]), _left);
	_top = min(floor(points_y[i]), _top);
	
	inertia += (points_x[i] * points_x[i] + points_y[i] * points_y[i]) * point_mass[i];
}

centre_of_mass_x = 0;
centre_of_mass_y = 0;

if (sprite_index != -1)
{
	sprite_set_offset(sprite_index, -_left, -_top);
	x += -_left;
	y += -_top;
}

var fix;
var polygons = bayazit_decompose(points_x, points_y);

for (var i = 0; i < array_length(polygons.x); i++)
{
	fix = physics_fixture_create(); physics_fixture_set_polygon_shape(fix);
	physics_fixture_set_collision_group(fix, 1);
	physics_fixture_set_restitution(fix, e);
	//physics_fixture_set_friction(fix, 0);
	physics_fixture_set_density(fix, body_static ? 0 : 1);
	
	try
	{
		for (var j = 0; j < array_length(polygons.x[i]); j++)
		{
			physics_fixture_add_point(fix, polygons.x[i][j], polygons.y[i][j]);
		}
	}
	catch (excep)
	{
		show_debug_message($"points x: {points_x}");
		show_debug_message($"points y: {points_y}");
		throw ($"\npoints x: {points_x}\n\npoints y: {points_y}");
	}
	
	physics_fixture_bind(fix, id);
	physics_fixture_delete(fix);
}