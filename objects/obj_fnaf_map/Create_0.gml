
global.map_selected = 0;
global.should_draw_map = 0;
image_index = image_last;
var _i = 0;
repeat(image_number-1){
	var _cria = instance_create_layer(x,y,"top_camera_buttons",obj_fnaf_map_button);
	_cria.image_index = _i;
	_cria.sprite_index = sprite_index;
	_i++;
}

var _cria = instance_create_layer(x,y,"camera",obj_fnaf_camera);

	