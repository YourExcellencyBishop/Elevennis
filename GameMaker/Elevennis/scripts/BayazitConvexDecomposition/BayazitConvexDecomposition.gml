function cross(ax, ay, bx, by) 
{
    return ax * by - ay * bx;
}

function polygon_area(xx, yy) 
{
    var area = 0;
    var n = array_length(xx);
    for (var i = 0; i < n; i++) 
	{
        var j = (i + 1) mod n;
        area += xx[i] * yy[j] - xx[j] * yy[i];
    }
    return area * 0.5;
}

function ensure_ccw(xx, yy) 
{
	var _xx = xx, _yy = yy;
	
    if (polygon_area(xx, yy) < 0) 
	{
        _xx = array_reverse(xx);
		_yy = array_reverse(yy)
    }
    return [_xx, _yy];
}

function is_reflex(xx, yy, i) 
{
    var n = array_length(xx);
    var prev_x = xx[(i - 1 + n) mod n];
	var prev_y = yy[(i - 1 + n) mod n];
    var curr_x = xx[i];
	var curr_y = yy[i];
    var next_x = xx[(i + 1) mod n];
	var next_y = yy[(i + 1) mod n];

    return cross(
        next_x - curr_x, next_y - curr_y,
        prev_x - curr_x, prev_y - curr_y
    ) < 0;
}

function segments_intersect(a_x, a_y, b_x, b_y, c_x, c_y, d_x, d_y) 
{
    function orient(p_x, p_y, q_x, q_y, r_x, r_y) 
	{
        return sign(cross(q_x - p_x, q_y - p_y, r_x - p_x, r_y - p_y));
    }

    var o1 = orient(a_x, a_y, b_x, b_y, c_x, c_y);
    var o2 = orient(a_x, a_y, b_x, b_y, d_x, d_y);
    var o3 = orient(c_x, c_y, d_x, d_y, a_x, a_y);
    var o4 = orient(c_x, c_y, d_x, d_y, b_x, b_y);

    return (o1 != o2) && (o3 != o4);
}

function left(ax, ay, bx, by, cx, cy) 
{
    return cross(bx - ax, by - ay, cx - ax, cy - ay) > 0;
}

function left_on(ax, ay, bx, by, cx, cy) 
{
    return cross(bx - ax, by - ay, cx - ax, cy - ay) >= 0;
}

function right(ax, ay, bx, by, cx, cy) 
{
    return cross(bx - ax, by - ay, cx - ax, cy - ay) < 0;
}

function right_on(ax, ay, bx, by, cx, cy) 
{
    return cross(bx - ax, by - ay, cx - ax, cy - ay) <= 0;
}

function in_cone(xx, yy, i, j) 
{
    var n = array_length(xx);

    var ix = xx[i], iy = yy[i];
    var jx = xx[j], jy = yy[j];

    var ip = (i - 1 + n) mod n;
    var inx = (i + 1) mod n;

    var px = xx[ip], py = yy[ip];
    var nx = xx[inx], ny = yy[inx];

    var convex = left_on(px, py, ix, iy, nx, ny);

    if (convex) 
	{
        return left(ix, iy, jx, jy, px, py)
            && right(ix, iy, jx, jy, nx, ny);
    } 
	else 
	{
        return !(left_on(ix, iy, jx, jy, nx, ny)
              && right_on(ix, iy, jx, jy, px, py));
    }
}

function point_in_polygon(xx, yy, px, py) 
{
    var inside = false;
    var n = array_length(xx);

    for (var i = 0, j = n - 1; i < n; j = i++) 
	{
        var xi = xx[i], yi = yy[i];
        var xj = xx[j], yj = yy[j];

        if (((yi > py) != (yj > py)) &&
            (px < (xj - xi) * (py - yi) / (yj - yi) + xi)) 
		{
            inside = !inside;
        }
    }
    return inside;
}

function is_visible(xx, yy, i, j) 
{

    var n = array_length(xx);

    var ax = xx[i], ay = yy[i];
    var bx = xx[j], by = yy[j];

    if (!in_cone(xx, yy, i, j)) return false;
    if (!in_cone(xx, yy, j, i)) return false;

    for (var k = 0; k < n; k++) 
	{
        var k2 = (k + 1) mod n;

        if (k == i || k == j || k2 == i || k2 == j) continue;

        if (segments_intersect(
            ax, ay, bx, by,
            xx[k], yy[k], xx[k2], yy[k2]
        )) {
            return false;
        }
    }

    var mx = (ax + bx) * 0.5;
    var my = (ay + by) * 0.5;

    if (!point_in_polygon(xx, yy, mx, my)) return false;

    return true;
}

function split_polygon(xx, yy, i, j) 
{
    var p1_x = [];
	var p1_y = [];
    var p2_x = [];
	var p2_y = [];

    var n = array_length(xx);

    var k = i;
    while (true) 
	{
        array_push(p1_x, xx[k]);
		array_push(p1_y, yy[k]);
        if (k == j) break;
        k = (k + 1) mod n;
    }

    k = j;
    while (true) 
	{
        array_push(p2_x, xx[k]);
		array_push(p2_y, yy[k]);
        if (k == i) break;
        k = (k + 1) mod n;
    }

    return [p1_x, p1_y, p2_x, p2_y];
}

function is_convex(xx, yy) 
{
    var n = array_length(xx);
    for (var i = 0; i < n; i++) 
	{
        if (is_reflex(xx, yy, i)) return false;
    }
    return true;
}

function bayazit_decompose(xx, yy) 
{
    var tt = ensure_ccw(xx, yy);
	xx = tt[0];
	yy = tt[1];

    var result = {x: [], y: []};

    if (is_convex(xx, yy)) 
	{
        array_push(result.x, xx);
		array_push(result.y, yy);
        return result;
    }

    var n = array_length(xx);

    for (var i = 0; i < n; i++) 
	{
        if (!is_reflex(xx, yy, i)) continue;

        for (var j = 0; j < n; j++) 
		{
            if (i == j) continue;
            if (!is_visible(xx, yy, i, j)) continue;

            var split = split_polygon(xx, yy, i, j);
            var a = bayazit_decompose(split[0], split[1]);
            var b = bayazit_decompose(split[2], split[3]);

            result.x = array_concat(result.x, a.x);
			result.x = array_concat(result.x, b.x);
			result.y = array_concat(result.y, a.y);
			result.y = array_concat(result.y, b.y);
			return result;
        }
    }

    array_push(result.x, xx);
	array_push(result.y, yy);
    return result;
}