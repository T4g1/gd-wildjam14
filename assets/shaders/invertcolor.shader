shader_type canvas_item;

void fragment()
{
	vec4 regular_color = texture(TEXTURE, UV);
	COLOR = vec4(
		1.0 - regular_color.r,
		1.0 - regular_color.g,
		1.0 - regular_color.b,
		regular_color.a
	);
}