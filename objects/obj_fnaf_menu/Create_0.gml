
zbar_changed = 0;


alpha = 0;
state = 0;
count = 0;
ox = 0;
oxd = -1;


randomize();

ini_open("save.ini");
	global.night = ini_read_real("save","noite",0);
	global.played_intro = ini_read_real("save","intro",0);
ini_close();

					sound_play(snd_scape,global.volume_sfx,1,0,1,1);
global.foda_music = sound_play(sfx_foda_music,0,1,0,1);

if (!global.played_intro){
	
	ini_open("save.ini");
		ini_write_real("save","intro",1);
	ini_close();
}