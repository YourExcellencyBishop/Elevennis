if (create_physics_body)
{
	paddles++;
	try
	{
		CreatePhysicsBodies(character, creation_data.surface, draw_area_x1 - 1, draw_area_y1 - 1, creation_data.width, creation_data.height, creation_data.buffer,
			creation_data.image_size, creation_data.bounds, global.SupportR8UnormSurface, paddles);
	} catch (lol) { /*Oopsie*/ }
		
	creation_data = INVALID;
	create_physics_body = false;
}

in_draw_area = point_in_rectangle(brush_position_x, brush_position_y, draw_area_x1, draw_area_y1, draw_area_x2, draw_area_y2);

size_arrow_phase = 2 * sin(current_time * 0.014); // change current_time to use delta_time