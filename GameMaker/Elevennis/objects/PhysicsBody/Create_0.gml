if (point_count == 0) instance_destroy();

var last_index = point_count - 1;
cyclic = abs(points_x[0] - points_x[last_index]) == 1 || abs(points_y[0] - points_y[last_index]) == 1;