if (create_physics_body)
{
	CreatePhysicsBodies(creation_data.surface, surface_x, surface_y, creation_data.width, creation_data.height, creation_data.buffer,
		creation_data.image_size, creation_data.bounds, global.SupportR8UnormSurface);
		
	creation_data = -1;
	create_physics_body = false;
}


size_arrow_sin = (2 * sin(current_time / 70));

switch (size_arrow_dir)
{
	case SizeArrowDir.Up:
		size_arrow_x = draw_area_x1 + (draw_area_x2 -  draw_area_x1) / 2;
		size_arrow_y = draw_area_y1 + size_arrow_sin;
		size_arrow_rot = 90;
		break;
		
	case SizeArrowDir.Down:
		size_arrow_x = draw_area_x1 + (draw_area_x2 -  draw_area_x1) / 2;
		size_arrow_y = draw_area_y2 + size_arrow_sin;
		size_arrow_rot = 270;
		break;
	
	case SizeArrowDir.Left:
		size_arrow_x = draw_area_x1 + size_arrow_sin;
		size_arrow_y = draw_area_y1 + (draw_area_y2 -  draw_area_y1) / 2;
		size_arrow_rot = 180;
		break;
	
	case SizeArrowDir.Right:
		size_arrow_x = draw_area_x2 + size_arrow_sin;
		size_arrow_y = draw_area_y1 + (draw_area_y2 -  draw_area_y1) / 2;
		size_arrow_rot = 0;
		break;
}
