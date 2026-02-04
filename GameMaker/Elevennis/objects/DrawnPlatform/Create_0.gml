#macro max_e 5
#macro min_e 0.5

swing = lerp(min_e, max_e, 1 - min(1, surface_area / 100));

color = make_colour_rgb(255 * swing / max_e, 255 * (1 - swing / max_e), 1);

event_inherited();

if (point_count == 0) throw "No points";

var last_index = point_count - 1;
// if the distance between the last and first pixel is 1 in any direction then it's a complete cycle
cyclic = abs(points_x[0] - points_x[last_index]) == 1 || abs(points_y[0] - points_y[last_index]) == 1;

mode = 1;

//show_debug_message($"Platform Power {e * 100}");
show_debug_message($"Surface {surface_area}");