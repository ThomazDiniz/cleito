
draw_set_font(fnt_comic_sans);
switch(state){
	case 0:
		sprite = choose(spr_cam_troll,spr_cam_forever,spr_cam_smile);
		ox = 0;
		oxd = choose(-1,1);
		state++;
	break;
	
	case 1:
		alpha+=0.01;
		if (count++>360) {
			state++;
			count = 0;
		}
	break;
	
	case 2:
		alpha -= 0.01;
		if (alpha < 0){
			state = 0;
		}
	break;
}
ox += oxd;
oxd*=0.995;
alpha = clamp(alpha,0,1);
draw_sprite_ext(sprite   ,0,room_width/2 + ox,room_height/2,1,1,0,image_blend,alpha);

var _s = wave_function(0,0.3,1000)
var _a = wave_function(-5,5,500)
draw_text_outline_transformed(room_width/2,100, "CLEITO, UM SEGURANÇA DA PESADA",2 + _s,2 + _s,_a);
draw_text_outline_transformed(room_width/2,190, "NOITE " + string(global.night+1), 2 + _s,2 + _s,_a);

if (options_button(100,room_height/2+300,"Começar o Jogar (Ganhar salário Mínimo)",800,100)) {
	room_goto(rm_fnaf);
}

global.volume_master = options_bar(100,1000,"VOLUME",300,64,global.volume_master);
if (zbar_changed) {
	audio_master_gain(global.volume_master);
}

if options_button(1400,800,"Jogue um de nossos \njogos na steam \npara nos apoiar! =)",400,240) {
	url_open("https://store.steampowered.com/search/?publisher=zelun_");
}
if ((os_type == os_android)){
	if options_button(500,1000,"POLÍTICA DE PRIVACIDADE",500,64) {
		url_open("https://zelun.wordpress.com/cleito-privacy-policy/");
	}
}
