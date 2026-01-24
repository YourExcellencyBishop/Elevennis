/// @function                CreatePhysicsBodies(sprite, surface_pos_x, surface_pos_y, x_offset, y_offset)
/// @description             Create physics bodies from a surface by extracting their edges.
/// @param {Id.Surface}		 surface		The surface.
/// @param {Real}			 surface_pos_x  The x position of the surface in the game world.
/// @param {Real}			 surface_pos_y  The y position of the surface in the game world.
/// @param {Real}			 x_offset  The x offset that points are placed in relation to their pixels.
/// @param {Real}			 y_offset  The y offset that points are placed in relation to their pixels.
/// @return {Array<Id.Instance<PhysicsBody>>} The instances.
function CreatePhysicsBodies(surface, surface_pos_x, surface_pos_y, x_offset = 0.5, y_offset = 0.5)
{
	var shader, fill_surf_format, bytes_per_pixel;
	var support_surface_r8unorm = global.SupportR8UnormSurface;
	
	if (support_surface_r8unorm)
	{
		shader = OnlyEdgesShaderR8;
		fill_surf_format = surface_r8unorm;
		bytes_per_pixel = byteCountR;
	}
	else 
	{
		shader = OnlyEdgesShader;
		fill_surf_format = surface_rgba8unorm;
		bytes_per_pixel = byteCountRGBA;
	}
	
	var bodies = array_create(0);
	var body_count = 0;

	#region Setting Up Surface

	// Puts a transparent pixel around the original image because GM edge clamps by default
	var shader_width = surface_get_width(surface);
	var shader_height = surface_get_height(surface);
	
	// the lengths without the extra transparency edge 
	var width = shader_width - 2;
	var height = shader_height - 2;

	// red channel contains whether pixel is filled on R8 format
	var fill_surf = surface_create(width, height, fill_surf_format);
	
	var _sampler = shader_get_sampler_index(shader, "u_Sampler");
	var _texture = surface_get_texture(surface);
	var _resolution = shader_get_uniform(shader, "u_Resolution");

	surface_set_target(fill_surf);
	shader_set(shader);

	texture_set_stage(_sampler, _texture);
	shader_set_uniform_f(_resolution, 1.0/shader_width, 1.0/shader_height);

	// drawn without transparent edge
	draw_surface(surface, -1, -1);

	shader_reset();
	surface_reset_target()

	var image_size = width * height;
	
	// RGBA stores 4 bytes per pixel and R stores 1
	var buf = buffer_create(image_size * bytes_per_pixel, buffer_fast, 1);
	buffer_get_surface(buf, fill_surf, 0);
	
	surface_free(fill_surf);

	#endregion

	#region Algorthim Setup

	// bit 0 is alpha [1 = filled, 0 = empty]
	// bit 1 is visited [1 = visited, 0 = not visited] 
	var state = array_create(image_size, 0); 
	var edge_count = 0;
	var i = 0;
	
	if (!support_surface_r8unorm)
	{
		var pos = alphaChannelIndex;
		repeat(image_size)
		{
		    if (buffer_peek(buf, pos, buffer_u8) != 0)
			{
				state[i] = EDGE.FILLED;
				edge_count++;
			}
			i++;
			pos += byteCountRGBA;
		}
	}
	else
	{
		buffer_seek(buf, buffer_seek_start, 0);
		repeat(image_size)
		{
			if (buffer_read(buf, buffer_u8) != 0)
			{
				state[i] = EDGE.FILLED;
				edge_count++;
			}
			i++;
		}
	}
	
	buffer_delete(buf);

	var dir_x = global.trace_dirs_x;
	var dir_y = global.trace_dirs_y;

	var scan_index = 0;
	#endregion

	var start_x, start_y, pos_x, pos_y;

	while (1)
	{
		var point_count = 0;
		var points_x = array_create(edge_count);
		var points_y = array_create(edge_count);
	
		#region Scan
	
		var found = 0;
	
		for (; scan_index < image_size; scan_index++)
		{
			if (state[scan_index] == EDGE.FILLED)
			{
				start_x = scan_index mod width; 
				start_y = scan_index div width;
				points_x[point_count] = start_x + x_offset + surface_pos_x;
				points_y[point_count++] = start_y + y_offset + surface_pos_y;
				pos_x = start_x;
				pos_y = start_y;
				found = 1;
				break;
			}
		}

		if (!found) break;
	
		#endregion
	
		#region Trace
	
		var last_dir = 0;
		var added_last = false;
		
		var total_offset_x = x_offset + surface_pos_x;
		var total_offset_y = y_offset + surface_pos_y;
	
		while (found)
		{		
			var next_x = -1, next_y;
			state[pos_x + pos_y * width] = EDGE.PROCESSED;
			
			var d = 0;
			for (; d < 8; d++) 
			{
				var dir = (last_dir + d) mod 8; // searches in last direction first
			    var nx = pos_x + dir_x[dir];
			    var ny = pos_y + dir_y[dir];

			    if (nx < 0 || nx >= width || ny < 0 || ny >= height) continue;

			    var idx = nx + ny * width;
			    if (state[idx] == EDGE.FILLED) 
				{
			        next_x = nx;
			        next_y = ny;
					pos_x = nx;
					pos_y = ny;
					last_dir = dir;
			        break;
			    }
			}
		
			if (next_x == -1)
			{ 
				if (!added_last)
				{
					points_x[point_count] = pos_x + total_offset_x;
					points_y[point_count++] = pos_y + total_offset_y;
				}
				break;
			}
		
			if (d != 0)
			{
				points_x[point_count] = next_x + total_offset_x;
				points_y[point_count++] = next_y + total_offset_y;
				added_last = true;
			}
			else added_last = false;
		}
	
		#endregion
		
		array_resize(points_x, point_count);
		array_resize(points_y, point_count);
		
		bodies[body_count++] = instance_create_depth(0, 0, depth - 1, PhysicsBody, 
			{points_x: points_x, points_y: points_y, point_count: point_count,
				sprite_index: sprite_create_from_surface(surface, 0, 0, shader_width, shader_height, false, false, 0, 0),
				x: surface_pos_x, y: surface_pos_y});
	}
	
	return bodies;
}