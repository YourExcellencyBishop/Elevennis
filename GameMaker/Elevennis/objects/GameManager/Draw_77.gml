draw_clear_alpha(c_black, 1);

var rand_x = random_range(-shake_intensity, shake_intensity);
var rand_y = random_range(-shake_intensity, shake_intensity);

shader_set(GridBackground);
draw_surface(grid, rand_x, rand_y)
shader_reset();

draw_surface_stretched(surf, rand_x, rand_y, view_get_wport(view_current), view_get_hport(view_current));