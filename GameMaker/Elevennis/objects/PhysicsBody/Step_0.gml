var dt = delta_time / 1000000;

if (!body_static)
{
	vx += (fx / total_mass) * dt;
	vy += (fy / total_mass) * dt;
	omega += (torque / inertia) * dt;
	
	x += vx * dt;
	y += vy * dt;
	image_angle += omega * dt;
}

fx = 0;
fy = 0;
torque = 0;