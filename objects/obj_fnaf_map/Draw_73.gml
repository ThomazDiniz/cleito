///@description 

if global.debug {
	draw_self();
	draw_sprite_ext(spr_fnaf_map_enemies,global.bunny.rota[global.bunny.position],x,y,1,1,0,c_white,image_alpha);
	draw_sprite_ext(spr_fnaf_map_enemies,global.chica.rota[global.chica.position],x+5,y,1,1,0,c_yellow,image_alpha);
	draw_sprite_ext(spr_fnaf_map_enemies,global.freddy.rota[global.freddy.position],x+10,y,1,1,0,c_red,image_alpha);
}