///@description 


x=0;
if (global.should_draw_map){
	y*=.9;
} else {
	y+=(2000-y)*.1;
}
var _changed = 0;
if (previous_map!=global.map_selected){
	previous_map = global.map_selected;
	noise_alpha = .2;
	_changed = 1;
}
if noise_alpha > .1{
	noise_alpha*=.97;
}

if (global.map_selected == 4 && global.foxy.state_attack != 0){
	var _spr = spr_cam_5;
	var _sw = sprite_get_width(_spr);
	var _sh = sprite_get_height(_spr);
	draw_sprite_ext(_spr,5,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);

	switch(global.foxy.state_attack){
		case 1:
			draw_sprite_ext(_spr,2,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha*.1);
			draw_sprite_ext(_spr,1,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);
		break;
		
		case 2:
			draw_sprite_ext(_spr,2,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha*.6);
			draw_sprite_ext(_spr,1,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);
		break;
		
		case 3:
			draw_sprite_ext(_spr,2,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);
			draw_sprite_ext(_spr,4,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);
		break;
		
		case 4:
			draw_sprite_ext(_spr,1,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);
		break;
	}
} else {
	var _spr = sprites[global.map_selected];
	var _sw = sprite_get_width(_spr);
	var _sh = sprite_get_height(_spr);
	draw_sprite_ext(_spr,0,x+_sw/2,y+_sh/2,1,1,image_angle,image_blend,image_alpha);
}

if (_changed) {
	if (global.map_selected == 6){
		audio_sound_gain(global.foda_music,1,100);
	} else {
		audio_sound_gain(global.foda_music,0,100);
	}
}

if (global.map_selected == 9 && global.foxy.state_attack == 4) {
	var _a = global.foxy.animation;
	var _x = x + 1820 - _a*1920;
	var _y = y + 0340 + _a*1000 + wave_function(-15,15,100);
	var _xs = min(2,.5+_a*2);
	var _ys = min(2,.5+_a*2);
	var _blend = merge_colour(c_black,c_red,min(1,_a));
	
	draw_sprite_ext(spr_cam_foxy,0,_x,_y,_xs,_ys,image_angle,_blend,image_alpha);
	global.foxy.animation+=.01;
}

if (global.bunny.rota[global.bunny.position] == global.map_selected) {
	var _img = 0;
	switch(global.map_selected) {
		case 9:
			_img = 5;
		break;
		
		case 7:
			_img = 4;
		break;
		
		case 5:
			_img = 3;
		break;
		
		default:
			_img = global.map_selected;
	}
	draw_sprite_ext(spr_cam_smile,_img,x+room_width/2,y+room_height/2,1,1,0,c_white,1);
}

if (global.freddy.rota[global.freddy.position] == global.map_selected && global.map_selected != 6 ) {
	var _img = 0;
	switch(global.map_selected) {
		case 3:
			_img = 2;
		break;
		
		case 8:
			_img = 3;
		break;
		
		case 10:
			_img = 4;
		break;
		
		default:
			_img = global.map_selected;
	}
	draw_sprite_ext(spr_cam_troll,_img,x+room_width/2,y+room_height/2,1,1,0,c_white,1);
}


if (global.chica.rota[global.chica.position] == global.map_selected && global.map_selected != 6 ) {
	var _img = 0;
	switch(global.map_selected) {
		case 3:
			_img = 2;
		break;
		
		case 8:
			_img = 3;
		break;
		
		case 10:
			_img = 4;
		break;
		
		default:
			_img = global.map_selected;
	}
	draw_sprite_ext(spr_cam_forever,_img,x+room_width/2,y+room_height/2,1,1,0,c_white,1);
}

draw_sprite_ext(spr_fnaf_noise,0,x-random(512),y+random(16),256,10,image_angle,c_white,noise_alpha);
draw_self();


if global.debug{
	global.ai = [global.freddy.ai_lvl,global.bunny.ai_lvl,global.chica.ai_lvl,global.foxy.ai_lvl];
	draw_text(room_width/2,100,global.ai);
}

