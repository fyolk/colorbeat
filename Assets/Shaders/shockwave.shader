shader_type canvas_item;

// Shockwave Shader @ by Nolkaloid
// https://www.youtube.com/watch?v=SCHdglr35pk

uniform vec2 center;
uniform float force;
uniform float size;
uniform float thickness;

void fragment() {
	float mask = 1.0 - smoothstep(size-0.1, size, length(SCREEN_UV - center))
				* smoothstep(size-thickness-0.1, size-thickness, length(SCREEN_UV - center));
	vec2 disp = normalize(SCREEN_UV - center) * force * mask;
	
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp);
}