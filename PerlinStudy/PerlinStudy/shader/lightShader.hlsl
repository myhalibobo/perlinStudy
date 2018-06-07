#version 330 core
out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

uniform sampler2D texture1;


uniform vec2 iResolution;

float grad(float p) {
	float v = texture(texture1, vec2(p / 256, 0.0)).r;
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
	//n(p) = (1 - F(p-p0))g(p0)(p-p0) + F(p-p0)g(p1)(p-p1)
}

void main()
{
	const float frequency = 1.0f / 20.0f;
	const float amplitude = 1.0f / 5.0f;

	float n = noise(TexCoord.x * frequency) * amplitude;
	float y = 2.0 * (TexCoord.y / iResolution.y) - 1.0;
	vec3 color = n >  y ? vec3(1.0) : vec3(0.0);

	FragColor = vec4(color, 1.0f);
	//FragColor = texture(texture1, TexCoord);
}