draw_clear_alpha(c_black, 1);

shader_set(GridBackground);
draw_surface(grid, 0, 0)
shader_reset();

draw_surface_stretched(surf, 0, 0, view_get_wport(view_current), view_get_hport(view_current));