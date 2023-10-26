if (!global.played_intro){
	sound_play(snd_scape,global.volume_sfx,1,0,1,1);
	global.foda_music = sound_play(sfx_foda_music,0,1,0,1);
}
zbar_changed = 0;


alpha = 0;
state = 0;
count = 0;
ox = 0;
oxd = -1;


randomize();