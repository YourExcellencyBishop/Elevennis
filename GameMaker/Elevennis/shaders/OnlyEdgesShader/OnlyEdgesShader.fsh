//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D uSampler;

void main()
{
    gl_FragColor = v_vColour * texture2D(uSampler, v_vTexcoord );
	
	int diag = 0;
	int perp = 0;
	
	float red = 0.;
	float green = 0.;
	float blue = 0.;
	float alpha = 0.;

	if (texture2D(uSampler, v_vTexcoord + vec2(0., -1./16.)).a > 0.)
	{ 
		perp++;
		red += 15.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(1./16., -1./16.)).a > 0.) 
	{
		diag++;
		red += (red == 0.) ? 15. : 240.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(1./16., 0)).a > 0.) 
	{
		perp++;
		green += 15.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(1./16., 1./16.)).a > 0.)
	{
		diag++;
		green += (green == 0.) ? 15. : 240.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(0., 1./16.)).a > 0.)
	{
		perp++;
		blue += 15.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(-1./16., 1./16.)).a > 0.)
	{
		diag++;
		blue += (blue == 0.) ? 15. : 240.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(-1./16., 0)).a > 0.)
	{
		perp++;
		alpha += 15.;
	}
	if (texture2D(uSampler, v_vTexcoord + vec2(-1./16., -1./16.)).a > 0.)
	{
		diag++;
		alpha += (alpha == 0.) ? 15. : 240.;
	}
	
	int count = perp + diag;
	
	// gl_FragColor = vec4(red / 255., green / 255., blue / 255., alpha / 255.);
	if (count > 7 || (perp > 2 && diag < 2) || (perp == 4) || (diag == 4)) gl_FragColor.a = 0.;
}
