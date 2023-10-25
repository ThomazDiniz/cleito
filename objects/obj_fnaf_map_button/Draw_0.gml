///@description 

if (global.should_draw_map){
	draw_self();
	if (global.map_selected == image_index) {
		draw_sprite_mask_color(c_white,.4);
	}
}