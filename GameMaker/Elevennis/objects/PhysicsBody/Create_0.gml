show_debug_overlay(1);

surf = surface_create(sprite_width, sprite_height)

surface_set_target(surf)

draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, 0, 0, 0);

surface_reset_target()

var count = 0;

for (var j = 0; j < sprite_height; j++)
{
	for (var i = 0; i < sprite_width; i++)
	{
		var pixel = surface_getpixel(surf, i, j);
		
		if (pixel > 0)
		{
			points[count] = [i, j];
			count++;
			
			break;
		}
	}
	
	if (array_length(points) > 0) break;
}

var findNext = true;
var nextPos = undefined;

while findNext
{
	var pos = points[count-1];
	var surroundingPixelValue = SurroundingValue(pos, surf);
	
	switch (surroundingPixelValue)
	{
		case 0b11100011: // Right
			nextPos = [pos[0] + 1, pos[1]];
			if (!array_equals(points[0], nextPos)) points[count] = nextPos;
			else findNext = false;
			break;
		case 0b10001111: // Down
			nextPos = [pos[0], pos[1] + 1];
			if (!array_equals(points[0], nextPos)) points[count] = nextPos;
			else findNext = false;
			break;
		case 0b00111110: // Left
			nextPos = [pos[0] - 1, pos[1]];
			if (!array_equals(points[0], nextPos)) points[count] = nextPos;
			else findNext = false;
			break;
		case 0b11111000: // Up
			nextPos = [pos[0], pos[1] - 1];
			if (!array_equals(points[0], nextPos)) points[count] = nextPos;
			else findNext = false;
			break;
		default:
			findNext = false;
			show_message("Missing Logic")
			break;
	}
	
	count++;
}


var _sampler = shader_get_sampler_index(OnlyEdgesShader, "uSampler");
var _texture = surface_get_texture(surf);

edited_surf = surface_create(surface_get_width(surf), surface_get_height(surf));
surface_set_target(edited_surf);
shader_set(OnlyEdgesShader);
texture_set_stage(_sampler, _texture);

draw_surface(surf, 0, 0);

shader_reset();
surface_reset_target();

custom_spr = sprite_create_from_surface(edited_surf, 0, 0, surface_get_width(edited_surf), surface_get_height(edited_surf), false, false, 0, 0);

surface_free(surf);
surface_free(edited_surf);

if (array_length(points) == 0)
{
	points[2] = [100, 100];
	points[1]= [1000, 100];
	points[0] = [500, 500];
}

function SurroundingValue(_pos, _surf)
{
	var value = 0b00000000;
	var pos_x = _pos[0];
	var pos_y = _pos[1];
	
	if !(surface_getpixel(_surf, pos_x + 0, pos_y - 1) > 0)	value |= 0b00000001;
	if !(surface_getpixel(_surf, pos_x + 1, pos_y - 1) > 0)	value |= 0b00000010;
	if !(surface_getpixel(_surf, pos_x + 1, pos_y + 0) > 0)	value |= 0b00000100;
	if !(surface_getpixel(_surf, pos_x + 1, pos_y + 1) > 0)	value |= 0b00001000;
	if !(surface_getpixel(_surf, pos_x + 0, pos_y + 1) > 0)	value |= 0b00010000;
	if !(surface_getpixel(_surf, pos_x - 1, pos_y + 1) > 0)	value |= 0b00100000;
	if !(surface_getpixel(_surf, pos_x - 1, pos_y + 0) > 0)	value |= 0b01000000;
	if !(surface_getpixel(_surf, pos_x - 1, pos_y - 1) > 0)	value |= 0b10000000;

	return value;
}