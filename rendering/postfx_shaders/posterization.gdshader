shader_type spatial;
render_mode unshaded;

uniform sampler2D screen_texture : source_color, hint_screen_texture, filter_nearest;
//uniform sampler2D screen_texture : source_color, hint_screen_texture, filter_nearest;
uniform float levels = 1.0;

void vertex() {
	POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	vec3 fragColor = texture(screen_texture, SCREEN_UV).rgb;
	float greyscale = max(fragColor.r, max(fragColor.g, fragColor.b));
	float lower     = floor(greyscale * levels) / levels;
	float lowerDiff = abs(greyscale - lower);
	
	float upper = ceil(greyscale * levels) / levels;
	float upperDiff = abs(upper - greyscale);
	
	float level = lowerDiff <= upperDiff ? lower : upper;
	float adjustment = level / greyscale;
	
	

	ALBEDO = fragColor.rgb * adjustment;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
