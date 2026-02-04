//6
//points_x = [ -2.67,-2.67,-1.67,3.33,2.33,1.33 ]
//points_y = [ -2,-1,0,1,1,1 ]

//5
//points_x = [ -5.11,-5.11,-4.11,-3.11,0.89,1.89,3.89,4.89,5.89 ]
//points_y = [ -0.78,0.22,1.22,1.22,0.22,0.22,-0.78,-0.78,-0.78 ]

//4
//points_x = [ -12.62,-10.62,-7.62,-6.62,-4.62,-3.62,-0.62,0.38,4.38,5.38,9.38,10.38,16.38 ]
//points_y = [ -14.38,-13.38,-9.38,-8.38,-5.38,-4.38,-0.38,0.62,5.62,6.62,11.62,12.62,18.62 ]

//3
//points_x = [ -3.78,-3.78,-2.78,-1.78,-0.78,1.22,2.22,3.22,6.22 ]
//points_y = [ -1.11,-0.11,1.89,1.89,0.89,-0.11,-1.11,-1.11,-1.11 ]

//2
//points_x = [ -17.85,-14.85,-13.85,-6.85,-5.85,-4.85,-3.85,-2.85,-2.85,-1.85,-0.85,1.15,2.15,3.15,5.15,6.15,13.15,14.15,15.15,16.15 ]
//points_y = [ -2.20,-1.20,-1.20,-0.20,-0.20,-1.20,-1.20,-0.20,0.80,-0.20,-0.20,0.80,-0.20,-0.20,0.80,0.80,1.80,1.80,0.80,0.80 ]

//1
//points_x = [ -18.23,-16.23,-15.23,-14.23,-10.23,-9.23,-6.23,-5.23,-3.23,-2.23,-1.23,-0.23,0.77,1.77,2.77,3.77,4.77,5.77,6.77,7.77,8.77,9.77,10.77,11.77,12.77,13.77 ]
//points_y = [ -11.27,-10.27,-10.27,-9.27,-6.27,-5.27,-3.27,-2.27,-1.27,-0.27,-0.27,0.73,0.73,1.73,1.73,2.73,2.73,3.73,3.73,4.73,4.73,5.73,5.73,6.73,6.73,7.73 ]

points_x = [ -7.25,-7.25,-6.25,-5.25,-4.25,-4.25,-3.25,-2.25,-1.25,-0.25,0.75,1.75,2.75,2.75,3.75,4.75,5.75,5.75,6.75,6.75 ]
points_y = [ -12.25,-11.25,-10.25,-8.25,-7.25,-6.25,-5.25,-3.25,-2.25,-0.25,0.75,2.75,3.75,4.75,5.75,7.75,8.75,9.75,10.75,11.75 ]

point_count = array_length(points_x);

ii = 0;
delay = 4;

alarm[0] = delay;


var fix;
var polygons = bayazit_decompose(points_x, points_y);

show_message(polygons)

//for (var q = 0; q < array_length(polygons.x); q++)
//{
//	fix = physics_fixture_create(); physics_fixture_set_polygon_shape(fix);
//	physics_fixture_set_collision_group(fix, 1);
//	physics_fixture_set_restitution(fix, 1);
//	//physics_fixture_set_friction(fix, 0);
//	physics_fixture_set_density(fix, true ? 0 : 1);
	
//	try
//	{
//		for (var j = 0; j < array_length(polygons.x[q]); j++)
//		{
//			physics_fixture_add_point(fix, polygons.x[q][j], polygons.y[q][j]);
//		}
//	}
//	catch (excep)
//	{
//		show_debug_message($"points_x = {points_x}");
//		show_debug_message($"points_y = {points_y}");
		
//		sprite_save(sprite_index, 0, "platform.png")
		
//		throw ($"\npoints_x = {points_x}\n\npoints_y = {points_y}");
//	}
	
//	physics_fixture_bind(fix, id);
//	physics_fixture_delete(fix);
//}