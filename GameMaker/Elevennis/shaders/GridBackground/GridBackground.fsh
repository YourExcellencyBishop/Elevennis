//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec2 pixel = v_vTexcoord * vec2(1366, 768);
	float grid_width = 4.;
	
	
	pixel += vec2(grid_width/2., grid_width/2.);
	
	
	if (mod(pixel.x, 30.) > grid_width && mod(pixel.y, 30.) > grid_width)
	{
		gl_FragColor.a = 0.0;
	}
}
