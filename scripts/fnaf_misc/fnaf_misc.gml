function fnaf_get_move_sound(){
	var _ar = [ sfx_low_ai_pai,
				sfx_low_aiiii,
				sfx_low_baladas,
				sfx_low_chinese_music,
				sfx_low_eunentendioqelefalo,
				sfx_low_flamengo,
				sfx_low_fodas1,
				sfx_low_fodas2,
				sfx_low_fodas3,
				sfx_low_gogogo,
				sfx_low_pare,
				sfx_low_peido,
				sfx_low_pirudopanico,
				sfx_low_quebom,
				sfx_low_risada_boleta,
				sfx_low_sport
			];
	return _ar[irandom(array_length(_ar)-1)];
}

function fnaf_play_sound_on_move(){
	if (random(1) > .5){
		var _snd = fnaf_get_move_sound();
		sound_play(_snd);
	}
}

global.played_intro = 0;