shader_type spatial;
uniform sampler2D baseAlbedo  :hint_default_white;

void vertex() {
	//VERTEX.y += cos(VERTEX.x + TIME * 0.05) * sin(VERTEX.z + TIME * 0.05); 
}

void fragment() {
	vec3 base = texture(baseAlbedo, UV * 100.0).rgb;
	
	ALBEDO =  base;
	ROUGHNESS = 1.0;
	SPECULAR = 0.0;
	METALLIC = 0.0;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
