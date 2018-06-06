#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aColor;
layout(location = 2) in vec2 aTexCoord;
layout(location = 3) in vec3 aNormal;

out vec4 outColor;
out vec2 textCoord;
out vec3 Normal;


void main() {
	gl_Position = projection * view * model * vec4(aPos , 1.0f);
}