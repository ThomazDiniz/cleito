///@description 


alarm[0] = 60*32;
global.fnaf_hora++;

switch(global.fnaf_hora){
	case 0:
	
	break;
	
	case 1:
	
	break;
	
	case 2:
		global.bunny.ai_lvl++;
	break;
	
	case 3:
		global.bunny.ai_lvl++;
		global.chica.ai_lvl++;
		global.foxy.ai_lvl++;
	break;
	
	case 4:
		global.bunny.ai_lvl++;
		global.chica.ai_lvl++;
		global.foxy.ai_lvl++;
	break;
	
	case 5:
		global.bunny.ai_lvl++;
		global.chica.ai_lvl++;
		global.foxy.ai_lvl++;
	break;
	
	default:
		instance_create_layer(0,0,"jumpscare",obj_fnaf_win);
	break;
}
