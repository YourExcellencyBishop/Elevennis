var spin = abs(phy_angular_velocity) / 1500;
target_color = (spin < 0.5 ? merge_colour(c_gray, c_red, spin / 0.5) : merge_colour(c_red, c_yellow, (spin - 0.5) / 0.5));
image_blend = merge_colour(image_blend, target_color, 0.2);