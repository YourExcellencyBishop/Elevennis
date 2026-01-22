var surf_width = sprite_width;
var surf_height = sprite_height;
var surf = surface_create(surf_width, surf_height)

surface_set_target(surf)

draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, 0, 0, 0);

surface_reset_target()

var _edited_surf = surface_create(surf_width, surf_height);
var _sampler = shader_get_sampler_index(OnlyEdgesShader, "u_Sampler");
var _texture = surface_get_texture(surf);
var _resolution = shader_get_uniform(OnlyEdgesShader, "u_Resolution");

surface_set_target(_edited_surf);
shader_set(OnlyEdgesShader);

texture_set_stage(_sampler, _texture);
shader_set_uniform_f(_resolution, surf_width, surf_height);

draw_surface(surf, 0, 0);

shader_reset();
surface_reset_target()

surface_free(surf);
surf = _edited_surf;

point_count = 0;

for (var j = 0; j < surf_height && point_count == 0; j++)
{
	for (var i = 0; i < surf_width; i++)
	{
		if (surface_getpixel(surf, i, j) > 0)
		{
			points[point_count++] = [i, j];
			break;
		}
	}
}

var nextPos = undefined;
visited = array_create(surf_width);
for (var i = 0; i < surf_width; i++)
    visited[i] = array_create(surf_height, false);

while (true)
{
	var pos = points[point_count-1];
	var pos_x = pos[0], pos_y = pos[1];
	var pixelValue = SurroundingValue(pos_x, pos_y, surf);
	
	if (pixelValue >= 0b10000000 && !visited[pos_x + 1][pos_y + 0]) nextPos = [pos_x + 1, pos_y + 0]; // Right
	else if (pixelValue >= 0b01000000 && !visited[pos_x + 1][pos_y + 1]) nextPos = [pos_x + 1, pos_y + 1]; // Right Down
	else if (pixelValue >= 0b00100000 && !visited[pos_x + 0][pos_y + 1]) nextPos = [pos_x + 0, pos_y + 1]; // Down
	else if (pixelValue >= 0b00010000 && !visited[pos_x - 1][pos_y + 1]) nextPos = [pos_x - 1, pos_y + 1]; // Left Down
	else if (pixelValue >= 0b00001000 && !visited[pos_x - 1][pos_y + 0]) nextPos = [pos_x - 1, pos_y + 0]; // Left
	else if (pixelValue >= 0b00000100 && !visited[pos_x - 1][pos_y - 1]) nextPos = [pos_x - 1, pos_y - 1]; // Left Up
	else if (pixelValue >= 0b00000010 && !visited[pos_x + 0][pos_y - 1]) nextPos = [pos_x + 0, pos_y - 1]; // Up
	else if (pixelValue >= 0b00000001 && !visited[pos_x + 1][pos_y - 1]) nextPos = [pos_x + 1, pos_y - 1]; // Right Up
	else break;

	visited[nextPos[0]][nextPos[1]] = true;

	if (!(array_equals(points[0], nextPos))) points[point_count++] = nextPos;
	else break;
}

custom_spr = sprite_create_from_surface(surf, 0, 0, surf_width, surf_height, false, false, 0, 0);

surface_free(surf);

if (point_count == 0)
{
	points = [[5, 5], [10, 1], [1, 1]];
	point_count =  3;
}
else
{
	for (var i = 0; i < point_count; i++)
		points[i] = [points[i][0] + 0.5, points[i][1] + 0.5];
}

function SurroundingValue(pos_x, pos_y, _surf)
{
	var value = 0b00000000;
	
	if (surface_getpixel(_surf, pos_x + 1, pos_y - 1) > 0 && !visited[pos_x + 1][pos_y - 1])	value |= 0b00000001; // Right Up
	if (surface_getpixel(_surf, pos_x + 0, pos_y - 1) > 0 && !visited[pos_x + 0][pos_y - 1])	value |= 0b00000010; // Up
	if (surface_getpixel(_surf, pos_x - 1, pos_y - 1) > 0 && !visited[pos_x - 1][pos_y - 1])	value |= 0b00000100; // Left Up
	if (surface_getpixel(_surf, pos_x - 1, pos_y + 0) > 0 && !visited[pos_x - 1][pos_y + 0])	value |= 0b00001000; // Left
	if (surface_getpixel(_surf, pos_x - 1, pos_y + 1) > 0 && !visited[pos_x - 1][pos_y + 1])	value |= 0b00010000; // Left Down
	if (surface_getpixel(_surf, pos_x + 0, pos_y + 1) > 0 && !visited[pos_x + 0][pos_y + 1])	value |= 0b00100000; // Down
	if (surface_getpixel(_surf, pos_x + 1, pos_y + 1) > 0 && !visited[pos_x + 1][pos_y + 1])	value |= 0b01000000; // Right Down
	if (surface_getpixel(_surf, pos_x + 1, pos_y + 0) > 0 && !visited[pos_x + 1][pos_y + 0])	value |= 0b10000000; // Right
	
	return value;
}