shader_type canvas_item;

uniform float value:hint_range(-1.0, 1.0, 0.1) = 0.5;

void fragment() {
	if (COLOR.a != 0.0){
		COLOR.a = step(0.5 + 0.5 * value, 1.0 - distance(vec2(0.5, 0), UV));
	}
}
//void vertex() {ertex the material is visible on.
//}

	// Called for every v
//void fragment() {
	//// Called for every pixel the material is visible on.
//}
//
//void light() {
	//// Called for every pixel for every light affecting the CanvasItem.
//}
