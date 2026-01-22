#region Setting Up Surface

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
#endregion

all_pixels = [];
visited = array_create(surf_width);

for (var i = 0; i < surf_width; i++)
{
    visited[i] = array_create(surf_height, false);
	for (var j = 0; j < surf_height; j++) all_pixels[i * surf_height + j] = [i , j];
}

var pixel_count = surf_width * surf_height;

while (pixel_count > 0)
{
	point_count = 0;
	points = []
	
	var found_start_pixel = false;
	for (var p = 0; p < pixel_count;)
	{
		var pixel = all_pixels[p];
		var _x = pixel[0], _y = pixel[1];
	
		found_start_pixel = surface_getpixel(surf, _x, _y) > 0;
	
		if (found_start_pixel)
		{
			points[point_count++] = [_x, _y];
			array_delete(all_pixels, 0, 1);
			pixel_count--;
			break;
		}
		
		array_delete(all_pixels, 0, 1);
		pixel_count--;
	}

	var nextPos = undefined;
	var cycle = false;

	while (found_start_pixel)
	{
		var pos = points[point_count - 1];
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

		if (!(array_equals(points[0], nextPos)))
		{
			points[point_count++] = nextPos;
			
			var index;
			for (index = 0; index < pixel_count; index++)
				if (array_equals(all_pixels[index], nextPos)) break;	
			
			array_delete(all_pixels, index, 1);
			pixel_count--;
		}
		else 
		{
			cycle = true;
			break;
		}
	}
	
	for (var i = 0; i < point_count; i++)
		points[i] = [points[i][0] + 0.5, points[i][1] + 0.5];
		
	instance_create_depth(0, 0, depth - 1, PhysicsBody, {points: points, point_count: point_count, cyclic: cycle});
}

sprite_index = sprite_create_from_surface(surf, 0, 0, surf_width, surf_height, false, false, 0, 0);
surface_free(surf);

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