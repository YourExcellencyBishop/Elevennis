/// @function                CreatePhysicsBodies(sprite, x_offset, y_offset)
/// @description             Create physics bodies from a surface by extracting their edges.
/// @param {Asset.GMSprite}  sprite		The surface.
/// @param {Real}			 x_offset  The x offset that points are placed in relation to their pixels.
/// @param {Real}			 y_offset  The y offset that points are placed in relation to their pixels.
/// @return {Array<Id.Instance<PhysicsBody>>} The instances.
function CreatePhysicsBodies(sprite, x_offset, y_offset)
{
	var shader = SupportR8Unorm ? OnlyEdgesShaderWin : OnlyEdgesShaderWeb;

	var bodies = array_create(0);
	var body_count = 0;

	#region Setting Up Surface

	var width = sprite_get_width(sprite);
	var height = sprite_get_height(sprite);

	// Puts a transparent pixel around the original image because GM edge clamps by defaul
	var shader_width = width + 2;
	var shader_height = height + 2;

	var surf = surface_create(shader_width, shader_height, SupportR8Unorm ? surface_rgba4unorm : surface_rgba8unorm)

	surface_set_target(surf)

	draw_clear_alpha(c_black, 0);
	draw_sprite(sprite_index, 0, 1, 1);

	surface_reset_target()

	// red channel contains whether pixel is filled
	var fill_surf = surface_create(width, height, SupportR8Unorm ? surface_r8unorm : surface_rgba8unorm);
	var _sampler = shader_get_sampler_index(shader, "u_Sampler");
	var _texture = surface_get_texture(surf);
	var _resolution = shader_get_uniform(shader, "u_Resolution");

	surface_set_target(fill_surf);
	shader_set(shader);

	texture_set_stage(_sampler, _texture);
	shader_set_uniform_f(_resolution, 1.0/shader_width, 1.0/shader_height);

	// drawn without transparent edge
	draw_surface(surf, -1, -1);

	shader_reset();
	surface_reset_target()

	surface_free(surf);

	var image_size = width * height;
	var buffer_size = SupportR8Unorm ? image_size : image_size * 4;
	var buf = buffer_create(buffer_size, buffer_fast, 1);
	buffer_get_surface(buf, fill_surf, 0);

	surface_free(fill_surf);
	#endregion

	#region Algorthim Setup

	// bit 0 is alpha [1 = filled, 0 = empty]
	// bit 1 is visited [1 = visited, 0 = alpha] 
	var state = array_create(image_size, 0); 
	var edge_count = 0;

	buffer_seek(buf, buffer_seek_start, 0);

	var i = 0
	repeat(image_size)
	{
		if (!SupportR8Unorm)
		{
			buffer_read(buf, buffer_u8);
			buffer_read(buf, buffer_u8);
			buffer_read(buf, buffer_u8);
		}
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
	#endregion

	while (1)
	{
		var point_count = 0;
		var points_x = array_create(edge_count);
		var points_y = array_create(edge_count);
	
		var start_x, start_y, pos_x, pos_y;
	
		#region Scan
	
		var found = 0;
	
		for (; scan_index < image_size; scan_index++)
		{
			if (state[scan_index] == 0b01)
			{
				start_x = scan_index mod width; 
				start_y = scan_index div width;
				points_x[point_count] = start_x + x_offset;
				points_y[point_count++] = start_y + y_offset;
				pos_x = start_x;
				pos_y = start_y;
				found = 1;
				break;
			}
		}

		if (!found) break;
	
		#endregion
	
		#region Trace
	
		var cycle = 0
		var last_dir = 0;
	
		while (found)
		{		
			var next_x = -1, next_y;
			state[pos_x + pos_y * width] = 0b11;

			for (var d = 0; d < 8; d++) 
			{
				var dir = (last_dir + d) mod 8; // searches in last direction first
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
		
			points_x[point_count] = next_x + x_offset;
			points_y[point_count++] = next_y + y_offset;
		}
	
		#endregion
		
		array_resize(points_x, point_count);
		array_resize(points_y, point_count);
		bodies[body_count++] = instance_create_depth(0, 0, depth - 1, PhysicsBody, {points_x: points_x, points_y: points_y, point_count: point_count});
	}
	
	return bodies;
}