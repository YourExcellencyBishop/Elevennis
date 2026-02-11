if (!surface_exists(surf)) { surf = surface_create(surf_width, surf_height); }

if (!surface_exists(grid)) { grid = surface_create(1366, 768); }

surface_set_target(grid);
draw_clear_alpha(c_white, 1);
surface_reset_target();

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
surface_reset_target();