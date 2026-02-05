if (create_physics_body)
{
	CreatePhysicsBodies(creation_data.surface, draw_area_x1 - 1, draw_area_y1 - 1, creation_data.width, creation_data.height, creation_data.buffer,
		creation_data.image_size, creation_data.bounds, global.SupportR8UnormSurface);
		
	creation_data = INVALID;
	create_physics_body = false;
}