if (create_physics_body)
{
	CreatePhysicsBodies(creation_data.surface, surface_x, surface_y, creation_data.width, creation_data.height, creation_data.buffer,
		creation_data.image_size, global.SupportR8UnormSurface);
		
	creation_data = -1;
	create_physics_body = false;
}