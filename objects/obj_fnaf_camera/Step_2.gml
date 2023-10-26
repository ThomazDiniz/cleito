///@description 


//general ai
for(var _i = 0; _i < array_length(animatronics); _i++) {
	var _struct = animatronics[_i];
	switch(_struct.state){
		case 0: //inicial
			_struct.state++;
			_struct.count=_struct.action_time;
		break;
	
		case 1: //pensando
			if (_struct.count-- < 0) {
				_struct.state++;
			}
		break;
	
		case 2: //ação
			if (_struct.ai_lvl > irandom(19)) { //decisão de avançar
				_struct.decision_function(1);
				fnaf_play_sound_on_move();
			}
			_struct.state = 1;
			_struct.count = _struct.action_time;
		break;
	}
}


var _struct = global.foxy
switch(_struct.state){
	case 0:// inicial
		_struct.state++;
		_struct.count=_struct.action_time;
	break;
	
	case 1: //pensando
		if (_struct.count-- < 0) {
			_struct.state++;
		}
		
		if (_struct.state_attack == 4){
			_struct.state=3;
			_struct.count = _struct.action_time;
		}
	break;
	
	case 2: //ação
		_struct.state=1;
		_struct.count = _struct.action_time;
		
		if (_struct.ai_lvl > irandom(19)) {
			_struct.state_attack++;
		}
		_struct.state_attack = clamp(_struct.state_attack,0,4);
		
		if (_struct.state_attack == 4){
			_struct.state=3;
			_struct.count = 900;
		}
	break;
	
	case 3: //atacando
		if (global.map_selected == 9 && _struct.animation == 0){
			sound_play(sfx_ratinhoooo);
			_struct.count=160;
		}
		
		if (_struct.count-- < 0){
			if (!global.door_right){
				global.should_draw_map=0;
				instance_create_layer(room_width/2,room_height/2,"jumpscare",obj_fnaf_jumpscare);
			} else {
				global.should_draw_map=0;
				_struct.state=1;
				_struct.count = _struct.action_time;
				_struct.state_attack = 0;
				_struct.animation = 0;
			}
		}
	break;
}

if keyboard_check_pressed(vk_f5) {
	global.debug = !global.debug; 
}

if (global.debug){
	if keyboard_check_pressed(vk_space){
		_struct.state_attack++;
	}

	if keyboard_check_pressed(vk_up){
		global.bunny.decision_function(1);
	}

	if keyboard_check_pressed(vk_down){
		global.bunny.decision_function(0);

	}

	if keyboard_check_pressed(vk_left){
		global.chica.decision_function(0);
	}

	if keyboard_check_pressed(vk_right){
		global.chica.decision_function(1);
	}

	if keyboard_check_pressed(ord("L")){
		global.freddy.decision_function(0);
	}

	if keyboard_check_pressed(ord("O")){
		global.freddy.decision_function(1);
	}
	
	if keyboard_check_pressed(vk_backspace){
		with(obj_fnaf_map_activate_button){
			event_perform(ev_alarm,0);
		}
	}
	
	
}