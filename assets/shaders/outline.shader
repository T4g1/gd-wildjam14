shader_type spatial;
render_mode unshaded;

uniform int intensity : hint_range(0,200); 
uniform float precision : hint_range(0,1);
uniform vec4 outline_color : hint_color;

uniform sampler2D texturemap : hint_albedo;


void fragment()
{
	
	vec4 color = texture(texturemap, UV);
	if (color.a < 1.0) {
		for (float x=-1.0; x<=1.0; x++) {
			for (float y=-1.0; y<=1.0; y++) {
				float vicinity = float(intensity) * precision;
				vec2 sample_position = vec2(
					UV.x + x * vicinity, 
					UV.y + y * vicinity
				);
				
				vec4 sample_color = texture(texturemap, sample_position);
				if (sample_color.a > color.a) {
					color = outline_color;
				}
			}
		}
	}
	
	ALBEDO = color.rgb; 
	ALPHA = color.a;
}