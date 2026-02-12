//physics_world_draw_debug(true)

//draw_text(0, 0, $"{display_get_height() > display_get_width() ? "portrait" : "landscape"}\nMouse ({mouse_x}, {mouse_y})");

if (!layer_get_visible(InGameLayer) || layer_get_visible(TutorialLayer)) draw_sprite_ext(PencilIcon, 0, (mouse_x * GameManager.scale_surf_width), (mouse_y * GameManager.scale_surf_height), 1, 1, icon_rot, c_white, 1);