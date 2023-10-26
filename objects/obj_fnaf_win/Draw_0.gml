
draw_set_font(fnt_comic_sans);
draw_set_font_align(fa_top,fa_left);

draw_set_alpha(image_alpha);
draw_set_colour(c_black);
	draw_rectangle(0,0,room_width,room_height,0);
draw_set_color(c_white);
	draw_text(100,room_height/2-16,"BOM DIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	draw_text(room_width/2,room_height/2+64,"Noite " + string(global.night+1));
draw_set_alpha(1);

image_alpha+=.01;

global.foxy.state = 0;
global.foxy.state = 0;

global.chica.state = 0;
global.chica.position = 0;

global.freddy.state = 0;
global.freddy.position = 0;

global.bunny.state = 0;
global.bunny.position = 0;