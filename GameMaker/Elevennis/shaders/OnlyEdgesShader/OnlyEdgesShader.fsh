//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_Sampler;
uniform vec2 u_Resolution;

bool inside(vec2 v)
{
	return all(greaterThanEqual(v, vec2(0.0))) && all(lessThanEqual(v, vec2(1.0)));
}

void main()
{
    gl_FragColor = v_vColour * texture2D(u_Sampler, v_vTexcoord );
	
	float res_x = u_Resolution.x;
	float res_y = u_Resolution.y;
	
	//int diag = 0;
	int perp = 0;
	
	float red = 0.;
	float green = 0.;
	float blue = 0.;
	float alpha = 0.;

	vec2 sample_pos = v_vTexcoord + vec2(0., -1./res_y);
	if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos))
	{ 
		perp++;
		red += 15.;
	}
	//sample_pos = v_vTexcoord + vec2(1./16., -1./16.);
	//if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos)) 
	//{
	//	diag++;
	//	red += (red == 0.) ? 15. : 240.;
	//}
	sample_pos = v_vTexcoord + vec2(1./res_x, 0);
	if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos)) 
	{
		perp++;
		green += 15.;
	}
	//sample_pos = v_vTexcoord + vec2(1./16., 1./16.);
	//if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos))
	//{
	//	diag++;
	//	green += (green == 0.) ? 15. : 240.;
	//}
	sample_pos = v_vTexcoord + vec2(0., 1./res_y);
	if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos))
	{
		perp++;
		blue += 15.;
	}
	//sample_pos = v_vTexcoord + vec2(-1./16., 1./16.);
	//if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos))
	//{
	//	diag++;
	//	blue += (blue == 0.) ? 15. : 240.;
	//}
	sample_pos = v_vTexcoord + vec2(-1./res_x, 0);
	if (texture2D(u_Sampler, sample_pos).a > 0. && inside(sample_pos))
	{
		perp++;
		alpha += 15.;
	}
	//sample_pos = v_vTexcoord + vec2(1./16., -1./16.);
	//if (texture2D(u_Sampler, v_vTexcoord + vec2(-1./16., -1./16.)).a > 0. && inside(sample_pos))
	//{
	//	diag++;
	//	alpha += (alpha == 0.) ? 15. : 240.;
	//}
	
	// gl_FragColor = vec4(red / 255., green / 255., blue / 255., alpha / 255.);
	if (perp == 4) gl_FragColor.a = 0.;
}
