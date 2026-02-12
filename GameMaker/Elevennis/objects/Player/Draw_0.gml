if (!GameManager.tutorial || TutorialManager.tutorial_state >=  TutorialState.YellowZone)
{
	draw_rectangle(platform_spawner.draw_area_x1, platform_spawner.draw_area_y1, platform_spawner.draw_area_x2, platform_spawner.draw_area_y2, true);
}

if (!GameManager.tutorial || TutorialManager.tutorial_state >= TutorialState.Finished)
{
	with (platform_spawner)
	{
		if (spawner_mode == SpawnerMode.ChangeSize)
		{
			var size_arrow_xx = size_arrow_x; 
			var size_arrow_yy = size_arrow_y;
			if (changing_draw_area_size)
			{	
				switch (size_arrow_dir)
				{
					case SizeArrowDir.Right:
					case SizeArrowDir.Left:
						size_arrow_yy = clamp(brush_position_y, draw_area_y1 + 7, draw_area_y2 - 7);
						break;
					case SizeArrowDir.Up:
					case SizeArrowDir.Down:
						size_arrow_xx = clamp(brush_position_x, draw_area_x1 + 7, draw_area_x2 - 7); 
						break;
				}
			}

			draw_sprite_ext(SizeArrow, 0, size_arrow_xx, size_arrow_yy, 1, 1, size_arrow_rot, c_white, 1);
		}
	}
}
