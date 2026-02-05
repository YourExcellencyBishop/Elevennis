/// @function                CreatePhysicsBodies(sprite, surface_pos_x, surface_pos_y, x_offset, y_offset)
/// @description             Create physics bodies from a surface by extracting their edges.
/// @param {Id.Surface}		 surface		The surface.
/// @param {Real}			 surface_pos_x  The x position of the surface in the game world.
/// @param {Real}			 surface_pos_y  The y position of the surface in the game world.
/// @param {Real}			 x_offset  The x offset that points are placed in relation to their pixels.
/// @param {Real}			 y_offset  The y offset that points are placed in relation to their pixels.
/// @return {Array<Id.Instance<PhysicsBody>>} The instances.
function CreateEdgeSurface(surface, support_surface_r8unorm)
{
	var shader, fill_surf_format, bytes_per_pixel;
	
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

	#region Setting Up Surface

	// Puts a transparent pixel around the original image because GM edge clamps by default
	var shader_width = surface_get_width(surface);
	var shader_height = surface_get_height(surface);
	
	var clip_buf = buffer_create(shader_width * shader_height * byteCountRGBA, buffer_fast, 1);
	buffer_get_surface(clip_buf, surface, 0);
	
	var _left = shader_width;
    var _right = 0;
    var _top = shader_height;
    var _bottom = 0;

    // Scan for opaque pixels
    for (var yy = 0; yy < shader_height; yy++) {
        for (var xx = 0; xx < shader_width; xx++) {
            var index = (yy * shader_width + xx) * 4 + 3; // Alpha byte
            var alpha = buffer_peek(clip_buf, index, buffer_u8);
            if (alpha > 0) { // any visible pixel
                if (xx < _left) _left = xx;
                if (xx > _right) _right = xx;
                if (yy < _top) _top = yy;
                if (yy > _bottom) _bottom = yy;
            }
        }
    }
	
	_right++;
	_bottom++;
	
	buffer_delete(clip_buf)
	
	// filled area of the image
	var width = _right - _left;
	var height = _bottom - _top;
	
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
	draw_surface(surface, -_left, -_top);

	shader_reset();
	surface_reset_target()

	var image_size = width * height;
	
	// RGBA stores 4 bytes per pixel and R stores 1
	var buf = buffer_create(image_size * bytes_per_pixel, buffer_fast, 1);
	buffer_get_surface(buf, fill_surf, 0);
	
	surface_free(fill_surf);

	return {surface: surface, buffer: buf, width: width, height: height, image_size: image_size, bounds: [_left, _top]};

	#endregion
}

function CreatePhysicsBodies(surface, surface_pos_x, surface_pos_y, width, height, buf, image_size, bounds, support_surface_r8unorm, x_offset = 0.5, y_offset = 0.5)
{

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

	var surface_area = 0;
	var _left = infinity, _top = infinity, _right = -infinity, _bottom = -infinity;
		
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
			points_x[point_count] = start_x;
			points_y[point_count++] = start_y;
			pos_x = start_x; pos_y = start_y;
			_left = pos_x; _right = pos_x;
			_top = pos_y; _bottom = pos_y;
				
			found = 1;
			break;
		}
	}

	if (!found) { return; }
	
	#endregion
	
	#region Trace
	
	var last_dir = 0;
	var added_last = false;
	
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
				points_x[point_count] = pos_x;
				points_y[point_count++] = pos_y;
					
				_left = min(_left, pos_x);
				_top = min(_top, pos_y);
					
				_right = max(_right, pos_x);
				_bottom = max(_bottom, pos_y);
			}
			surface_area++;
			break;
		}
		
		if (d != 0)
		{
			points_x[point_count] = next_x;
			points_y[point_count++] = next_y;
				
			_left = min(_left, next_x);
			_top = min(_top, next_y);
				
			_right = max(_right, next_x);
			_bottom = max(_bottom, next_y);
				
			added_last = true;
		}
		else added_last = false;
			
		surface_area++;
	}
	
	#endregion
		
	array_resize(points_x, point_count);
	array_resize(points_y, point_count);
		
	var body = instance_create_depth(surface_pos_x + bounds[0] + _left, surface_pos_y + bounds[1] + _top, depth - 1, DrawnPlatform, 
		{points_x: points_x, points_y: points_y, point_count: point_count,
			sprite_index: sprite_create_from_surface(surface, bounds[0] + _left, bounds[1] + _top, floor(_right - _left) + 1, floor(_bottom - _top) + 1, false, false, 0, 0),
			surface_area: surface_area,
			body_type: PhysicsBodyType.Edge});
	
	surface_free(surface);	
	return body;
}