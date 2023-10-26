///@description 


////REMOVER ISSO DAQUI 
////REMOVER ISSO DAQUI 
////REMOVER ISSO DAQUI 
if keyboard_check_pressed(vk_control){
	event_perform(ev_alarm,0);
}
////REMOVER ISSO DAQUI 
////REMOVER ISSO DAQUI 
////REMOVER ISSO DAQUI 

draw_self();

draw_set_font(fnt_comic_sans);
draw_set_font_align(fa_left,fa_top);
	draw_text(300,870,"Energia: " + string(ceil(global.fnaf_energia)) + "%" );
	draw_text(300,910,"Uso: ");
	draw_text(300,950,"Hora: 0" + string(global.fnaf_hora)+ ":00" );

var _uso =	global.should_draw_map + global.door_left + 
			global.light_left + global.door_right + 
			global.light_right;

var _i = 0;
var _px = 385;
repeat(_uso){
	draw_sprite(spr_fnaf_energy_usage,_i++,_px,935);
	_px+=19;
}

var _uso_padrao = min(2,global.night)/10;
global.fnaf_energia -= (_uso*.15 + _uso_padrao)/60;	


if (global.fnaf_energia <= 0) {
	global.should_draw_map=0;
	instance_create_layer(room_width/2,room_height/2,"jumpscare",obj_fnaf_jumpscare,{image_index:3});
}
