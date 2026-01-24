if (point_count == 0) instance_destroy();

var last_index = point_count - 1;
// if the distance between the last and first pixel is 1 in any direction then it's a complete cycle
cyclic = abs(points_x[0] - points_x[last_index]) == 1 || abs(points_y[0] - points_y[last_index]) == 1;

mode = 1;