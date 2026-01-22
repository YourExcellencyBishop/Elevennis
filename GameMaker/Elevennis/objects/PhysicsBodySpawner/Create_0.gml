var start_time = current_time;

#region Setting Up Surface

var width = sprite_width + 2;
var height = sprite_height + 2;
var surf = surface_create(width, height)

surface_set_target(surf)

draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, 0, 1, 1);

surface_reset_target()

var _edited_surf = surface_create(width - 2, height - 2);
var _sampler = shader_get_sampler_index(OnlyEdgesShader, "u_Sampler");
var _texture = surface_get_texture(surf);
var _resolution = shader_get_uniform(OnlyEdgesShader, "u_Resolution");

surface_set_target(_edited_surf);
shader_set(OnlyEdgesShader);

texture_set_stage(_sampler, _texture);
shader_set_uniform_f(_resolution, 1/width, 1/height);

draw_surface(surf, -1, -1);

shader_reset();
surface_reset_target()

surface_free(surf);

var buf = buffer_create(width * height * 4, buffer_fast, 1);
buffer_get_surface(buf, _edited_surf, 0);

width -= 2;
height -= 2;
sprite_index = sprite_create_from_surface(_edited_surf, 0, 0, width, height, false, false, 0, 0);

surface_free(_edited_surf);
#endregion

var visited = array_create(width * height, false);

while (true)
{
	point_count = 0;
	points_x = []
	points_y = []
	
	var found = false;
	var start_x, start_y;
	
	for (var _x = 0; _x < width; _x++)
	for (var _y = 0; _y < height; _y++)
	{
		
		if (!visited[_x + _y * width] && buffer_peek(buf, ((_y * width) + _x) * 4 + 3, buffer_u8) > 0)
		{
			points_x[point_count] = _x;
			points_y[point_count++] = _y;
			start_x = _x; 
			start_y = _y;
			found = true;
			break;
		}
	}

	if (!found) break;
	
	var cycle = false;
	
	while (found)
	{
		var next_x = -1, next_y = -1;
		var pos_x = points_x[point_count - 1], pos_y = points_y[point_count - 1];

		var base = (pos_y * width + pos_x) * 4 + 3;
		
		var can_l = pos_x > 0;
	    var can_r = pos_x < width - 1;
	    var can_u = pos_y > 0;
	    var can_d = pos_y < height - 1;
	
		if (can_r && !visited[(pos_x + 1) + pos_y * width] && buffer_peek(buf, base + 4, buffer_u8) > 0) 
			{ next_x = pos_x + 1; next_y = pos_y + 0; }
		else if (can_r && can_d && !visited[(pos_x + 1) + (pos_y + 1) * width] && buffer_peek(buf, base + 4 + 4 * width, buffer_u8) > 0) 
			{ next_x = pos_x + 1; next_y = pos_y + 1; }
		else if (can_d && !visited[(pos_x + 0) + (pos_y + 1) * width] && buffer_peek(buf, base + 0 + 4 * width, buffer_u8) > 0) 
			{ next_x = pos_x + 0; next_y = pos_y + 1; }
		else if (can_l && can_d && !visited[(pos_x - 1) + (pos_y + 1) * width] && buffer_peek(buf, base - 4 + 4 * width, buffer_u8) > 0) 
			{ next_x = pos_x - 1; next_y = pos_y + 1; }
		else if (can_l && !visited[(pos_x - 1) + (pos_y + 0) * width] && buffer_peek(buf, base - 4, buffer_u8) > 0) 
			{ next_x = pos_x - 1; next_y = pos_y + 0; }
		else if (can_l && can_u && !visited[(pos_x - 1) + (pos_y - 1) * width] && buffer_peek(buf, base - 4 - 4 * width, buffer_u8) > 0) 
			{ next_x = pos_x - 1; next_y = pos_y - 1; }
		else if (can_u && !visited[(pos_x + 0) + (pos_y - 1) * width] && buffer_peek(buf, base + 0 - 4 * width, buffer_u8) > 0) 
			{ next_x = pos_x + 0; next_y = pos_y - 1; }
		else if (can_r && can_u && !visited[(pos_x + 1) + (pos_y - 1) * width] && buffer_peek(buf, base + 4 - 4 * width, buffer_u8) > 0) 
			{ next_x = pos_x + 1; next_y = pos_y - 1; }
		else break;

		visited[next_x + next_y * width] = true;

		if (!(next_x == start_x && next_y == start_y))
		{
			points_x[point_count] = next_x;
			points_y[point_count++] = next_y;
		}
		else 
		{
			cycle = true;
			break;
		}
	}
	
	for (var i = 0; i < point_count; i++)
	{
		points_x[i] += 0.5;
		points_y[i] += 0.5;
	}
		
	instance_create_depth(0, 0, depth - 1, PhysicsBody, {points_x: points_x, points_y: points_y, point_count: point_count, cyclic: cycle});
}

show_message(current_time - start_time);