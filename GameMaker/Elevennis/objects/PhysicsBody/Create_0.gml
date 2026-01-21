//show_debug_overlay(1);

surf = surface_create(sprite_width, sprite_height)

surface_set_target(surf)

draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, 0, 0, 0);

surface_reset_target()


var _sampler = shader_get_sampler_index(OnlyEdgesShader, "uSampler");
var _texture = surface_get_texture(surf);

var edited_surf = surface_create(surface_get_width(surf), surface_get_height(surf));
surface_set_target(edited_surf);
shader_set(OnlyEdgesShader);
texture_set_stage(_sampler, _texture);

draw_surface(surf, 0, 0);

shader_reset();
surface_reset_target()

surface_free(surf);
surf = edited_surf;

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

var nextPos = undefined;
visited = array_create(sprite_width);
for (var i = 0; i < sprite_width; i++) {
    visited[i] = array_create(sprite_height, false);
}

while true
{
	var pos = points[count-1];
	var surroundingPixelValue = SurroundingValue(pos, surf);
	
	if (surroundingPixelValue >= 0b10000000 && !visited[pos[0] + 1][pos[1] + 0]) nextPos = [pos[0] + 1, pos[1] + 0]; // Right
	else if (surroundingPixelValue >= 0b01000000 && !visited[pos[0] + 1][pos[1] + 1]) nextPos = [pos[0] + 1, pos[1] + 1]; // Right Down
	else if (surroundingPixelValue >= 0b00100000 && !visited[pos[0] + 0][pos[1] + 1]) nextPos = [pos[0] + 0, pos[1] + 1]; // Down
	else if (surroundingPixelValue >= 0b00010000 && !visited[pos[0] - 1][pos[1] + 1]) nextPos = [pos[0] - 1, pos[1] + 1]; // Left Down
	else if (surroundingPixelValue >= 0b00001000 && !visited[pos[0] - 1][pos[1] + 0]) nextPos = [pos[0] - 1, pos[1] + 0]; // Left
	else if (surroundingPixelValue >= 0b00000100 && !visited[pos[0] - 1][pos[1] - 1]) nextPos = [pos[0] - 1, pos[1] - 1]; // Left Up
	else if (surroundingPixelValue >= 0b00000010 && !visited[pos[0] + 0][pos[1] - 1]) nextPos = [pos[0] + 0, pos[1] - 1]; // Up
	else if (surroundingPixelValue >= 0b00000001 && !visited[pos[0] + 1][pos[1] - 1]) nextPos = [pos[0] + 1, pos[1] - 1]; // Right Up
	else break;

	visited[nextPos[0]][nextPos[1]] = true;

	if (!(array_equals(points[0], nextPos))) 
	{
		points[count] = nextPos;
		count++;
	}
	else break;
}


custom_spr = sprite_create_from_surface(surf, 0, 0, surface_get_width(surf), surface_get_height(surf), false, false, 0, 0);

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
	
	if (surface_getpixel(_surf, pos_x + 1, pos_y - 1) > 0 && !visited[pos_x + 1][pos_y - 1])	value |= 0b00000001; // Right Up
	if (surface_getpixel(_surf, pos_x + 0, pos_y - 1) > 0 && !visited[pos_x + 0][pos_y - 1])	value |= 0b00000010; // Up
	if (surface_getpixel(_surf, pos_x - 1, pos_y - 1) > 0 && !visited[pos_x - 1][pos_y - 0])	value |= 0b00000100; // Left Up
	if (surface_getpixel(_surf, pos_x - 1, pos_y + 0) > 0 && !visited[pos_x - 1][pos_y + 0])	value |= 0b00001000; // Left
	if (surface_getpixel(_surf, pos_x - 1, pos_y + 1) > 0 && !visited[pos_x - 1][pos_y + 1])	value |= 0b00010000; // Left Down
	if (surface_getpixel(_surf, pos_x + 0, pos_y + 1) > 0 && !visited[pos_x + 0][pos_y + 1])	value |= 0b00100000; // Down
	if (surface_getpixel(_surf, pos_x + 1, pos_y + 1) > 0 && !visited[pos_x + 1][pos_y + 1])	value |= 0b01000000; // Right Down
	if (surface_getpixel(_surf, pos_x + 1, pos_y + 0) > 0 && !visited[pos_x + 1][pos_y + 0])	value |= 0b10000000; // Right
	
	return value;
}