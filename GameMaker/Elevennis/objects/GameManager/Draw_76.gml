if (!surface_exists(surf)) { surf = surface_create(surf_width, surf_height); }

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
surface_reset_target();