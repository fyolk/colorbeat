shader_type canvas_item;

void fragment() {
	vec4 display = texture(TEXTURE, UV);
	display.a = display.r == 1.0 ? 0.1 : 0.0;
	display.rg = (SCREEN_UV + abs(sin(TIME))) * 0.5;
	COLOR = display;
	//COLOR = vec4((SCREEN_UV + abs(sin(TIME))) * 0.5, 1.0, 1.0);
}