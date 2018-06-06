#version 330 core

out vec4 FragColor;
in vec2 fragCoord;

uniform sampler2D iChannel0;
uniform float texture_width;
uniform vec2 iResolution;

float grad(float p) {
	float v = texture(iChannel0, vec2(p / texture_width, 0.0)).r;
	return v > 0.5 ? 1.0 : -1.0;
}

/* S-shaped curve for 0 <= t <= 1 */
float fade(float t) {
	return t*t*t*(t*(t*6.0 - 15.0) + 10.0);
}


/* 1D noise */
float noise(float p) {
	float p0 = floor(p);
	float p1 = p0 + 1.0;

	float t = p - p0;
	float fade_t = fade(t);

	float g0 = grad(p0);
	float g1 = grad(p1);

	return (1.0 - fade_t)*g0*(p - p0) + fade_t*g1*(p - p1);
}

void main()
{
	//const float frequency = 1.0 / 20.0;
	//const float amplitude = 1.0 / 5.0;
	//float n = noise(fragCoord.x * frequency) * amplitude;
	//float y = 2.0 * (fragCoord.y / iResolution.y) - 1.0; /* map fragCoord.y into [-1; 1] range */
	//vec3 color = n >  y ? vec3(1.0) : vec3(0.0);
	
	//texture(iChannel0, vec2(p / texture_width, 0.0))
	FragColor = vec4(1.0f);
	//FragColor = texture(iChannel0, fragCoord);
}