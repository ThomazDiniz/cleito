alarm[0] = 140;

image_xscale = 1;
image_yscale = 1;

ox = choose(-2000,2000);
oy = choose(-2000,2000);


if (instance_number(object_index) > 1) {
	instance_destroy();
}

global.should_draw_map = 0;

played = 0;