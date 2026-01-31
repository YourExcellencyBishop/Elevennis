var maxPen = 0;
var corr_nx = 0;
var corr_ny = 0;

for (var i = 0; i < point_count; i++)
{
	var cosA = cos(degtorad(-image_angle));
	var sinA = sin(degtorad(-image_angle));
	
	var lx = points_x[i];
	var ly = points_y[i];
	
	var px = x + cosA * lx - sinA * ly;
	var py = y + sinA * lx + cosA * ly;
	
	var n_x = 0;
	var n_y = 0;
	
	var penetration = 0;
	
	if (px < 0)
	{
		n_x = 1;
		penetration = -px;
	}
	else if (px > GameManager.surf_width)
	{
		n_x = -1;
		penetration = px - GameManager.surf_width;
	}
	else if (py < 0)
	{
		n_y =1;
		penetration = -py;
	}
	else if (py > GameManager.surf_height)
	{
		n_y = -1;
		penetration = py - GameManager.surf_height;
	}
	
	var rx = px - x;
	var ry = py - y;
	
	var vpx = vx - omega * ry;
	var vpy = vy + omega * rx;
	
	var vn = vpx * n_x + vpy * n_y;
	if (vn >= 0) continue;
	
	var rCrossN = rx * n_y - ry * n_x;
	
	var J = -(1 + restitution) * vn /
            (1 / total_mass + (rCrossN * rCrossN) / inertia);

    vx += (J * n_x) / total_mass;
    vy += (J * n_y) / total_mass;
    omega += (rCrossN * J) / inertia;

    // positional correction
    if (penetration > maxPen)
	{
	    maxPen = penetration;
	    corr_nx = n_x;
	    corr_ny = n_y;
	}
}

x += corr_nx * maxPen;
y += corr_ny * maxPen;