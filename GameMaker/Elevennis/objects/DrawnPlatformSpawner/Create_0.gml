// Body
create_physics_body = false;
creation_data = INVALID;

// Brush
brush_position_x = INVALID;
brush_position_y = INVALID;

prev_brush_position_x = INVALID;
prev_brush_position_y = INVALID;

brush_size = 2;

// Checks
drawing = false;
drew = false;
start_drawing = false;

// Bounds
bounds_width = bounds_x2 - bounds_x1;
bounds_height = bounds_y2 - bounds_y1;
var bounds_centre_x = bounds_x1 + bounds_width * 0.5;
var bounds_centre_y = bounds_y1 + bounds_height * 0.5;

// Surface
surface = INVALID;
#macro surface_x bounds_x1
#macro surface_y bounds_y1
#macro surface_width bounds_width
#macro surface_height bounds_height

// Draw Area
draw_area = -1;
changing_draw_area_size = false;
resize_draw_area = false;

draw_area_size = draw_area_side*draw_area_side;

draw_area_x1 = bounds_centre_x - draw_area_side * 0.5;
draw_area_x2 = bounds_centre_x + draw_area_side * 0.5;
draw_area_y1 = bounds_centre_y - draw_area_side * 0.5;
draw_area_y2 = bounds_centre_y + draw_area_side * 0.5;

#macro draw_area_width (draw_area_x2 - draw_area_x1)
#macro draw_area_height (draw_area_y2 - draw_area_y1)

min_draw_area_width = draw_area_size / bounds_height;
min_draw_area_height = draw_area_size / bounds_width;

// Size Arrow
size_arrow_x = INVALID;
size_arrow_y = INVALID;
size_arrow_rot = 0;
size_arrow_dir = SizeArrowDir.Right;

// Mode
spawner_mode = SpawnerMode.Draw;

// Out Zone
out_zone = MakeBoxSensor(bounds_x1, room_height - 3, bounds_x2, room_height, OutZone, depth - 1);
out_zone.color = out_zone_color;
out_zone.character = character;
out_zone.func = function()
{
	character.enemy.total_score++;
	with (GameManager)
	{
		reset_game();
	}
}