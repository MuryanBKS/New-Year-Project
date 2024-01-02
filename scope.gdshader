shader_type canvas_item;

uniform float amt : hint_range(0.0, 1.0);
uniform vec4 color : source_color;
uniform vec4 t_color : source_color;


void fragment() 
{
	vec4 input_color = texture(TEXTURE, UV);
	if (distance(UV, vec2(0.5,0.5)) > amt/2.0) 
	{
		COLOR = vec4(color);
	}
	else 
	{
		COLOR = vec4(t_color);
	}
}