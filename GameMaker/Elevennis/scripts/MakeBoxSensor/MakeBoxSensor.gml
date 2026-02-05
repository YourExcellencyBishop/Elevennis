function MakeBoxSensor(x1, y1, x2, y2, sensor, _depth)
{
	var centre_x = (x1 + x2) / 2;
	var centre_y = (y1 + y2) / 2;
	
	return instance_create_depth(centre_x, centre_y, _depth, sensor, 
	{
		half_width: (x2 - x1) / 2,
		half_height: (y2 - y1) / 2
	});
}