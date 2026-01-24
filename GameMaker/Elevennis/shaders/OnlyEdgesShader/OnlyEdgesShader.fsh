//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_Sampler;
uniform vec2 u_Resolution;

void main()
{
    vec4 col = v_vColour * texture2D(u_Sampler, v_vTexcoord);

    if (col.a == 0.0) 
	{
        gl_FragColor = col;
        return;
    }
	
	vec2 px = u_Resolution;

	float perp = 0.0;
	
	// Checks if alpha is greater than 0.5 for each perpendicular direction
    perp += step(0.5, texture2D(u_Sampler, v_vTexcoord + vec2(0.0, -px.y)).a);
    perp += step(0.5, texture2D(u_Sampler, v_vTexcoord + vec2(px.x, 0.0)).a);
    perp += step(0.5, texture2D(u_Sampler, v_vTexcoord + vec2(0.0, px.y)).a);
    perp += step(0.5, texture2D(u_Sampler, v_vTexcoord + vec2(-px.x, 0.0)).a);
	
	// if all 4 surrounding perpendicular pixels are filled, then this pixel is blank
	col.a *= step(perp, 3.5);

	gl_FragColor = col;
}