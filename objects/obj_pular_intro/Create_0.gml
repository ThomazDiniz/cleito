if !global.played_intro {
	alarm[1] = 300;
} else {
	instance_destroy();
}

conta = 0;
global.played_intro = 1;

