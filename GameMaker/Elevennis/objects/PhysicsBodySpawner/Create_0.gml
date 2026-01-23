var t = current_time;

#region Setting Up Surface

var width = sprite_width;
var height = sprite_height;
var shader_width = width + 2;
var shader_height = height + 2;

var surf = surface_create(shader_width, shader_height, surface_rgba4unorm)

surface_set_target(surf)

draw_clear_alpha(c_black, 0);
draw_sprite(sprite_index, 0, 1, 1);

surface_reset_target()

var _edited_surf = surface_create(width, height, surface_r8unorm);
var _sampler = shader_get_sampler_index(OnlyEdgesShader, "u_Sampler");
var _texture = surface_get_texture(surf);
var _resolution = shader_get_uniform(OnlyEdgesShader, "u_Resolution");

surface_set_target(_edited_surf);
shader_set(OnlyEdgesShader);

texture_set_stage(_sampler, _texture);
shader_set_uniform_f(_resolution, 1.0/shader_width, 1.0/shader_height);

draw_surface(surf, -1, -1);

shader_reset();
surface_reset_target()

surface_free(surf);

var image_size = width * height;
var buf = buffer_create(image_size, buffer_fast, 1);
buffer_get_surface(buf, _edited_surf, 0);

//sprite_index = sprite_create_from_surface(_edited_surf, 0, 0, width, height, false, false, 0, 0);

surface_free(_edited_surf);
#endregion

var state = array_create(image_size, 0);
var edge_count = 0;

buffer_seek(buf, buffer_seek_start, 0);

var i = 0
repeat(image_size)
{
    if (buffer_read(buf, buffer_u8) != 0)
	{
		state[i] = 0b01;
		edge_count++;
	}
	i++;
}
buffer_delete(buf);

var dir_x = [ 1, 1, 0, -1, -1, -1,  0, 1 ];
var dir_y = [ 0, 1, 1,  1,  0, -1, -1,-1 ];

var scan_index = 0;

while (1)
{
	var point_count = 0;
	var points_x = array_create(edge_count);
	var points_y = array_create(edge_count);
	
	var found = 0;
	var start_x, start_y, pos_x, pos_y;
	
	for (; scan_index < image_size; scan_index++)
	{
		if (state[scan_index] == 0b01)
		{
			start_x = scan_index mod width; 
			start_y = scan_index div width;
			points_x[point_count] = start_x + 0.5;
			points_y[point_count++] = start_y + 0.5;
			pos_x = start_x;
			pos_y = start_y;
			found = 1;
			break;
		}
	}

	if (!found) break;
	
	var cycle = 0
	var last_dir = 0;
	
	while (found)
	{		
		var next_x = -1, next_y;
		state[pos_x + pos_y * width] = 0b11;

		for (var d = 0; d < 8; d++) 
		{
			var dir = (last_dir + d) mod 8;
		    var nx = pos_x + dir_x[dir];
		    var ny = pos_y + dir_y[dir];

		    if (nx < 0 || nx >= width || ny < 0 || ny >= height) continue;

		    var idx = nx + ny * width;
		    if (state[idx] == 0b01) {
		        next_x = nx;
		        next_y = ny;
				pos_x = nx;
				pos_y = ny;
				last_dir = d;
		        break;
		    }
		}
		
		if (next_x == -1) break;
		
		points_x[point_count] = next_x + 0.5;
		points_y[point_count++] = next_y + 0.5;
	}
		
	array_resize(points_x, point_count);
	array_resize(points_y, point_count);
	instance_create_depth(0, 0, depth - 1, PhysicsBody, {points_x: points_x, points_y: points_y, point_count: point_count});
}

show_message(current_time - t);