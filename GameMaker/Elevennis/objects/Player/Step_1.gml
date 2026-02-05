with (platform_spawner)
{
	prev_brush_position_x = brush_position_x;
	prev_brush_position_y = brush_position_y;
	brush_position_x = floor(mouse_x * GameManager.scale_surf_width);
	brush_position_y = floor(mouse_y * GameManager.scale_surf_height);

	in_draw_area = point_in_rectangle(brush_position_x, brush_position_y, draw_area_x1, draw_area_y1, draw_area_x2, draw_area_y2);

	var mouse_dist = infinity;

	if (!changing_draw_area_size)
	{
	    mouse_dist = abs(brush_position_x - draw_area_x1);
	    size_arrow_dir = SizeArrowDir.Left;

	    var d = abs(brush_position_x - draw_area_x2);
	    if (d < mouse_dist) { mouse_dist = d; size_arrow_dir = SizeArrowDir.Right; }

	    d = abs(brush_position_y - draw_area_y1);
	    if (d < mouse_dist) { mouse_dist = d; size_arrow_dir = SizeArrowDir.Up; }

	    d = abs(brush_position_y - draw_area_y2);
	    if (d < mouse_dist) { mouse_dist = d; size_arrow_dir = SizeArrowDir.Down; }
	}

	size_arrow_phase = 2 * sin(current_time * 0.014); // change current_time to use delta_time

	var draw_area_cx = draw_area_x1 + (draw_area_x2 - draw_area_x1) * 0.5;
	var draw_area_cy = draw_area_y1 + (draw_area_y2 - draw_area_y1) * 0.5;

	switch (size_arrow_dir)
	{
	    case SizeArrowDir.Up:
	        size_arrow_x = draw_area_cx;
	        size_arrow_y = draw_area_y1 + size_arrow_phase;
	        size_arrow_rot = 90;
	        break;

	    case SizeArrowDir.Down:
	        size_arrow_x = draw_area_cx;
	        size_arrow_y = draw_area_y2 + size_arrow_phase;
	        size_arrow_rot = 270;
	        break;

	    case SizeArrowDir.Left:
	        size_arrow_x = draw_area_x1 + size_arrow_phase;
	        size_arrow_y = draw_area_cy;
	        size_arrow_rot = 180;
	        break;

	    case SizeArrowDir.Right:
	        size_arrow_x = draw_area_x2 + size_arrow_phase;
	        size_arrow_y = draw_area_cy;
	        size_arrow_rot = 0;
	        break;
	}
}