// Body
create_physics_body = false;
creation_data = INVALID;

// Drawing
draw_centre_x = INVALID;
draw_centre_y = INVALID;

draw_position_x = INVALID;
draw_position_y = INVALID;

draw_last_position_x = INVALID;
draw_last_position_y = INVALID;

brush_size = 2;

// Surface
surface_size = initialDrawSurfaceSize;
draw_surfaces = array_create(5, -1);
surface_index = 0;
surface = INVALID;
surface_centre = INVALID;
surface_x = INVALID;
surface_y = INVALID;

// Checks
drawing = false;
drew = false;
premature_draw = false;
start_drawing = false;
out_of_bounds_draw = false;
make_new_start_surface = false;
new_start_surface = false;

// Bounds
bounds_x1 = 40;
bounds_y1 = 70;
bounds_x2 = 120;
bounds_y2 = 160;

var bounds_width = bounds_x2 - bounds_x1;
var bounds_height = bounds_y2 - bounds_y1;
var bounds_centre_x = bounds_x1 + bounds_width * 0.5;
var bounds_centre_y = bounds_y1 + bounds_height * 0.5;

// Draw Area
draw_area = -1;
changing_draw_area_size = false;
resize_draw_area = false;
draw_area_clear = false;

var draw_area_side = 50;
draw_area_size = draw_area_side*draw_area_side;

draw_area_x1 = bounds_centre_x - draw_area_side * 0.5;
draw_area_x2 = bounds_centre_x + draw_area_side * 0.5;
draw_area_y1 = bounds_centre_y - draw_area_side * 0.5;
draw_area_y2 = bounds_centre_y + draw_area_side * 0.5;

min_draw_area_width = draw_area_size / bounds_height;
min_draw_area_height = draw_area_size / bounds_width;

// Size Arrow
size_arrow_x = -1;
size_arrow_y = -1;
size_arrow_rot = 0;
size_arrow_dir = SizeArrowDir.Right;

// Mode
spawner_mode = SpawnerMode.Draw;