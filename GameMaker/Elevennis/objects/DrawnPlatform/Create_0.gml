event_inherited();

#macro max_power 5
#macro min_power 0.5

swing = lerp(min_power, max_power, 1 - min(1, surface_area / 100));
color = make_colour_rgb(255 * swing / max_power, 255 * (1 - swing / max_power), 1);
alarm[0] = 1;

if (point_count == 0) throw "No points";

// show_debug_message($"Surface Area of {surface_area}");