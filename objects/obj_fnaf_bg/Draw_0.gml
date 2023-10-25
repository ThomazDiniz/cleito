
var _light_1 = random(1)<.9;
var _light_2 = random(1)<.9;


if (global.light_left && _light_1) {
	draw_sprite_ext(sprite_index,5,0,0,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	if (global.chica.rota[global.chica.position] == 11){
		if (!global.chica.animation){
			global.chica.animation = 1;
			sound_play(sfx_pare);
		}
		draw_sprite_ext(spr_cam_forever,5,x+room_width/2,y+room_height/2,1,1,0,c_white,1);
	}
}

if (global.light_right && _light_2){
	draw_sprite_ext(sprite_index,6,0,0,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	if (global.bunny.rota[global.bunny.position] == 11){
		if (!global.bunny.animation) {
			global.bunny.animation = 1;
			sound_play(sfx_among);
		}
		draw_sprite_ext(spr_cam_smile,6,x+room_width/2,y+room_height/2,1,1,0,c_white,1);
	}
}


draw_sprite_ext(sprite_index,1,0,l_door_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
draw_sprite_ext(sprite_index,2,0,r_door_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

draw_self();

if (global.light_left && _light_1) {
	draw_sprite_ext(sprite_index,3,0,0,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}
if (global.light_right && _light_2){
	draw_sprite_ext(sprite_index,4,0,0,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}


if (global.door_left) {
	l_door_y += (0-l_door_y)*.2;
} else {
	l_door_y += (-2000-l_door_y)*.2;
}

if (global.door_right) {
	r_door_y += (0-r_door_y)*.2;
} else {
	r_door_y += (-2000-r_door_y)*.2;
}