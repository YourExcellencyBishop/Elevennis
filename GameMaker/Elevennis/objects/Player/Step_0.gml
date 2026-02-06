if (PauseManager.paused) exit;

with (platform_spawner)
{
	if (mouse_check_button(mb_left))
	{	
		if (mouse_check_button_pressed(mb_left)) 
		{
			if (spawner_mode == SpawnerMode.ChangeSize && 
				point_in_circle(brush_position_x, brush_position_y, size_arrow_x, size_arrow_y, 5))
			{
				changing_draw_area_size = true;
			}
			else if (spawner_mode == SpawnerMode.Draw) { start_drawing = true; }
		}
	
		if (changing_draw_area_size)
		{
			var overflow;
		
			// draw_area_size = (draw_area_x2 - draw_area_x1) * (draw_area_y2 - draw_area_y1);
			switch (size_arrow_dir)
			{
				case SizeArrowDir.Right:
					draw_area_x2 = clamp(brush_position_x, draw_area_x1 + min_draw_area_width, bounds_x2);
					draw_area_y1 = draw_area_y2 - (draw_area_size / (draw_area_x2 - draw_area_x1));
	
					overflow = min(0, draw_area_y1 - bounds_y1);
					draw_area_y2 -= overflow;
					draw_area_y1 -= overflow;
					break;
				
				case SizeArrowDir.Left:
					draw_area_x1 = clamp(brush_position_x, bounds_x1, draw_area_x2 - min_draw_area_width);
					draw_area_y2 = (draw_area_size / (draw_area_x2 - draw_area_x1)) + draw_area_y1;
			
					overflow = max(0, draw_area_y2 - bounds_y2);
					draw_area_y1 -= overflow;
					draw_area_y2 -= overflow;
					break;
				
				case SizeArrowDir.Up:
					draw_area_y1 = clamp(brush_position_y, bounds_y1, draw_area_y2 - min_draw_area_height);
					draw_area_x2 = (draw_area_size / (draw_area_y2 - draw_area_y1)) + draw_area_x1;
			
					overflow = max(0, draw_area_x2 - bounds_x2);
					draw_area_x1 -= overflow;
					draw_area_x2 -= overflow;
					break;
				
				case SizeArrowDir.Down:
					draw_area_y2 = clamp(brush_position_y, draw_area_y1 + min_draw_area_height, bounds_y2);
					draw_area_x1 = draw_area_x2 - (draw_area_size / (draw_area_y2 - draw_area_y1));
			
					overflow = min(0, draw_area_x1 - bounds_x1);
					draw_area_x2 -= overflow;
					draw_area_x1 -= overflow;
					break;
			}
		}
		else if (start_drawing && in_draw_area)
		{
			start_drawing = false;
			drawing = true;
		}
		else if (drew && !in_draw_area) { create_physics_body = true; }
	
		if (drawing && in_draw_area) { drew = true; }
	}
	else 
	{
		if (changing_draw_area_size)
		{
			changing_draw_area_size = false;	
			resize_draw_area = true;
		}
	
		if (drawing)
		{
			drawing = false;
			create_physics_body = drew;
		}
	}
	
	if (!PauseManager.ready_to_play)
	{
		draw_set_font(InGameFont);
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		
		if (mouse_check_button_released(mb_left) and
			point_in_rectangle(brush_position_x, brush_position_y, 
			bounds_centre_x - string_width("Ready? [  X  ]") / 2, bounds_y1 - ready_to_play_space - string_height("Ready? [  X  ]"), 
			bounds_centre_x + string_width("Ready? [  X  ]") / 2, bounds_y1 - ready_to_play_space))
		{
			other.ready_to_play = !other.ready_to_play;
		}
	}
}