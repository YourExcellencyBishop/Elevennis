var point_list_count = array_length(points_x);

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

var fix;
switch (body_type)
{
	case PhysicsBodyType.Polygon:
		
		for (var l = 0; l < point_list_count; l++)
		{
			var polygons = bayazit_decompose(points_x[l], points_y[l]);

			for (var i = 0; i < array_length(polygons.x); i++)
			{
				fix = physics_fixture_create(); physics_fixture_set_polygon_shape(fix);
				physics_fixture_set_collision_group(fix, collision_group);
				physics_fixture_set_restitution(fix, e);
				physics_fixture_set_density(fix, body_static ? 0 : 1);
	
				for (var j = 0; j < array_length(polygons.x[i]); j++)
				{
					physics_fixture_add_point(fix, polygons.x[i][j], polygons.y[i][j]);
				}
	
				physics_fixture_bind(fix, id);
				physics_fixture_delete(fix);
			}
		}
		break;
	
	case PhysicsBodyType.Edge:
		
		fix = physics_fixture_create(); 
		physics_fixture_set_collision_group(fix, collision_group);
		physics_fixture_set_restitution(fix, e);
		physics_fixture_set_density(fix, body_static ? 0 : 1);
		
		for (var i = 0; i < point_list_count; i++)
		{
			var point_list_length = array_length(points_x[i]);
			for (var j = 0, k = INVALID; j < point_list_length; j++)
			{
				k = (j + 1) % point_list_length;
				physics_fixture_set_edge_shape(fix, points_x[i][j], points_y[i][j], points_x[i][k], points_y[i][k]);
				physics_fixture_bind(fix, id);
			}
		}
		
		physics_fixture_delete(fix);
	
		break;
}