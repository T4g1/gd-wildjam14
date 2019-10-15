shader_type spatial;
render_mode unshaded;

uniform int intensity : hint_range(0,200); 
uniform float precision : hint_range(0,1);
uniform vec4 outline_color : hint_color;

uniform sampler2D texturemap : hint_albedo;

varying vec3 o;
varying vec3 f;

void vertex()
{
	o = VERTEX;
	//vec2 uv = (UV - 0.5);
	//VERTEX += uv * float(intensity);
	f = VERTEX;
}

void fragment()
{
	ivec2 t = textureSize(texturemap, 0);
	vec2 regular_uv;
	regular_uv.x = UV.x + (f.x - o.x)/float(t.x);
	regular_uv.y = UV.y + (f.y - o.y)/float(t.y);
	
	vec4 regular_color = texture(texturemap, regular_uv);
	if((regular_uv.x < 0.0 || regular_uv.x > 1.0) || (regular_uv.y < 0.0 || regular_uv.y > 1.0) || regular_color.a <=0.25){
		regular_color = vec4(0.0); 
	}
	
	vec2 ps = vec2(0.01, 0.01) * float(intensity) * precision;
	
	vec4 final_color = regular_color;
	if (regular_color.a <= 0.0) // this if is worth it as it stops several extra executions that might just be uneccessary but it's hardware dependent so I am still not sure
	{
		for(int x = -1; x <= 1; x += 1){
			for(int y = -1; y <= 1; y += 1){

				vec2 outline_uv = regular_uv + vec2(float(x) * ps.x, float(y) * ps.y); 
				
				vec4 outline_sample = texture(texturemap, outline_uv);
				if((outline_uv.x < 0.0 || outline_uv.x > 1.0) || (outline_uv.y < 0.0 || outline_uv.y > 1.0)){
					//We aren't a real color
					outline_sample = vec4(0);
				}
				
				//Is our sample empty? Is there something nearby?					
				if(outline_sample.a > final_color.a){
					final_color = outline_color;
				}
			}
		}
	}
	
	ALBEDO = final_color.rgb; 
	ALPHA = final_color.a;
}