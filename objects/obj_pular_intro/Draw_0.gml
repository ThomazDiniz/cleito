///@description 

if (conta++ > 2960) {
	if (each_milliseconds(100)){
		draw_sprite_ext(spr_fnag_pipe, irandom(100), 300,300, 2,2, 0, image_blend, image_alpha);
	}
}

if conta > 3300 {
	instance_destroy();
}
draw_self();



