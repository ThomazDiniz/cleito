///@description 

y = 2000;
sound_play(choose(sfx_oleo_de_macaco,sfx_among,sfx_pare,sfx_low_eunentendioqelefalo,sfx_low_chinese_music));

sprites = [
	spr_cam_1,spr_cam_2,spr_cam_3,
	spr_cam_4, spr_cam_5,spr_cam_6,
	spr_cam_7,spr_cam_8,spr_cam_9,
	spr_cam_10,spr_cam_11
];
previous_map = 0;
noise_alpha = 1;

global.foxy = {
	state:0,
	state_attack: 0,
	count:0,
	position:0,
	route:[5,10,11],
	animation: 0,
	ai_lvl: 0,
	action_time: 5.01*60,
}

global.freddy = {
	state:0,
	position:0,
	rota:[0,1,3,6,8,10,11],
	animation: 0,
	decision_function: function(_forward) {
		if (_forward) {
			switch(position){
				case 1:
					position = choose(4,2);
				break;
			
				default:
					position++;
			}
		} else {
			switch(position){
				case 4:
					position = choose(1,3);
				break;
			
				default:
					position--;
			}
		
		}
		if (position == array_length(rota)) {
			if (!global.door_left) {
				global.should_draw_map=0;
				instance_create_layer(room_width/2,room_height/2,"jumpscare",obj_fnaf_jumpscare,{image_index:3});
			} else {
				position = irandom(array_length(rota)-2);
				animation = 0;
			}
		}
		position = clamp(position,0,array_length(rota)-1);
	},
	count: 0,
	attack:0,
	attack_count:0,
	ai_lvl: 0,
	forward: 1,
	action_time: 3.5*60,
}

global.bunny = {
	state:0,
	position:0,
	rota:[0,1,2,5,7,9,11],
	animation: 0,
	decision_function: function(_forward) {
		if (_forward) {
			position++;
		} else {
			position--;
		}
		if (position == array_length(rota)){
			if (!global.door_right){
				global.should_draw_map=0;
				instance_create_layer(room_width/2,room_height/2,"jumpscare",obj_fnaf_jumpscare,{image_index:2});
			} else {
				position = irandom(array_length(rota)-2);
				animation = 0;
			}
		}
		position = clamp(position,0,array_length(rota)-1);
	},
	count: 0,
	attack:0,
	attack_count:0,
	ai_lvl: 0,
	forward: 1,
	action_time: 4.9*60,
}

global.chica = {
	state:0,
	position:0,
	rota:[0,1,3,6,8,10,11],
	animation: 0,
	decision_function: function(_forward) {
		if (_forward) {
			switch(position){
				case 1:
					position = choose(4,2);
				break;
			
				default:
					position++;
			}
		} else {
			switch(position){
				case 4:
					position = choose(1,3);
				break;
			
				default:
					position--;
			}
		
		}
		if (position == array_length(rota)){
			if (!global.door_left) {
				global.should_draw_map=0;
				instance_create_layer(room_width/2,room_height/2,"jumpscare",obj_fnaf_jumpscare,{image_index:1});
			} else {
				position = irandom(array_length(rota)-2);
				animation = 0;
			}
		}
		position = clamp(position,0,array_length(rota)-1);
	},
	count: 0,
	attack:0,
	attack_count:0,
	ai_lvl: 0,
	forward: 1,
	action_time: 4.98*60,
}

animatronics = [global.bunny,global.chica,global.freddy];

function set_ai_lvl(_freddy=0,_bunny=0,_chica=0,_foxy=0) {
	global.foxy.ai_lvl	  = _foxy;
	global.freddy.ai_lvl  = _freddy;
	global.bunny.ai_lvl   = _bunny;
	global.chica.ai_lvl   = _chica;
	
}

function set_night_difficult(_night = global.night){
	switch(_night){
		case 00:		set_ai_lvl(0,5,0,0);				break;
		case 01:		set_ai_lvl(0,3,5,1);				break;
		case 02:		set_ai_lvl(5,5,5,5);				break;
		case 03:		set_ai_lvl(2+irandom(2),7,7,7);		break;
		case 04:		set_ai_lvl(3,5,7,5);				break;
		case 05:		set_ai_lvl(4,10,12,16);				break;
		case 20:		set_ai_lvl(20,20,20,20);			break;
		default:		set_ai_lvl(irandom(20),irandom(20),irandom(20),irandom(20));
	}													
}

set_night_difficult();