point_list_count = array_length(points_x);

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
	
	case PhysicsBodyType.Circle:
		fix = physics_fixture_create();
		physics_fixture_set_collision_group(fix, collision_group);
		physics_fixture_set_restitution(fix, e);
		physics_fixture_set_density(fix, body_static ? 0 : 1);
		physics_fixture_set_circle_shape(fix, points_x[0][0]);
		physics_fixture_bind(fix, id);
		physics_fixture_delete(fix);
		break;
		
	default:
		throw "Unhandled Physics Body Type!";
		break;
}