draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	
image_blend =  make_colour_rgb(lerp(colour_get_red(image_blend), colour_get_red(color), 0.1), 
				lerp(colour_get_green(image_blend), colour_get_green(color), 0.1), 
				lerp(colour_get_blue(image_blend), colour_get_blue(color), 0.1));