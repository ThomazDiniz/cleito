
global.should_draw_map = 0;
var _snd = sfx_jumpscare_troll;
switch(floor(image_index)){
	case 0:
		_snd = sfx_jumpscare_foxy;
	break;
	
	case 1:
		_snd = sfx_jumpscare_chica;
	break;
	
	case 2:
		_snd = sfx_jumpscare_bunny;
	break;
}

if (image_index == 0){
}
if (abs(ox) + abs(oy) < 100 && !played) {
	sound_play(_snd)
	played = 1
}

if (abs(ox) + abs(oy) < 1) {
	var _c = .1;
	image_xscale+=_c;
	image_yscale+=_c;
}

ox*=.8;
oy*=.8;
var _x = x;
var _y = y;
x+= ox +random_d(32);
y+= oy +random_d(32);
draw_self();
x = _x;
y = _y;