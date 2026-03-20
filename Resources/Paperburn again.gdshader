shader_type canvas_item;

uniform sampler2D a;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 og = texture(TEXTURE, UV);
	vec4 mask = texture(a, UV);
	COLOR.a *= mask.a;


	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
