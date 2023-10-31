#macro view_cam view_camera[0]
#macro view_port 0
#macro view_x camera_get_view_x(view_camera[0])
#macro view_y camera_get_view_y(view_camera[0])
#macro view_width camera_get_view_width(view_camera[0])
#macro view_height camera_get_view_height(view_camera[0])
#macro window_width window_get_width()
#macro window_height window_get_height()
#macro view_xview camera_get_view_x(view_camera[0])
#macro view_yview camera_get_view_y(view_camera[0])
#macro view_xborder camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])
#macro view_yborder camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])
#macro view_xcenter camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2
#macro view_ycenter camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2

#macro gui_xborder display_get_gui_width()
#macro gui_yborder display_get_gui_height()
#macro gui_xcenter display_get_gui_width()/2
#macro gui_ycenter display_get_gui_height()/2
#macro mouse_x_gui (mouse_x - camera_get_view_x(view_camera[0]))
#macro mouse_y_gui (mouse_y - camera_get_view_y(view_camera[0]))
#macro mouse_x_previous _mx_previous
#macro mouse_y_previous _my_previous
#macro mouse_moved _mouse_moved
#macro mouse_dx _mdx
#macro mouse_dy _mdy
#macro mouse_click				mouse_check_button_pressed(mb_left)	
#macro mouse_clicking			mouse_check_button(mb_left)			
#macro mouse_released			mouse_check_button_released(mb_left)
#macro mouse_right_click		mouse_check_button_pressed(mb_right)
#macro mouse_right_clicking		mouse_check_button(mb_right)		
#macro mouse_right_released		mouse_check_button_released(mb_right)
#macro mouse_middle_click		mouse_check_button_pressed(mb_middle)
#macro mouse_middle_clicking	mouse_check_button(mb_middle)		
#macro mouse_middle_released	mouse_check_button_released(mb_middle)
#macro delete_button_clicked	mouse_right_click	

#macro mouse_any_click mouse_click || mouse_middle_click || mouse_right_click
#macro mouse_any_clicking mouse_clicking || mouse_middle_clicking || mouse_right_clicking
#macro mouse_any_released mouse_released || mouse_middle_released || mouse_right_released
#macro ctrl_click keyboard_check_pressed(vk_control)
#macro ctrl_clicking keyboard_check(vk_control)
#macro ctrl_released keyboard_check_released(vk_control)
#macro shift_click keyboard_check_pressed(vk_shift)
#macro shift_clicking keyboard_check(vk_shift)
#macro shift_released keyboard_check_released(vk_shift)
#macro alt_click keyboard_check_pressed(vk_alt)
#macro alt_clicking keyboard_check(vk_alt)
#macro alt_released keyboard_check_released(vk_alt)
#macro image_last (image_number-1)
#macro view_ycenter_top view_y - view_height/2
#macro view_ycenter_bottom view_y + view_height/2
#macro view_xcenter_left view_x - view_width/2
#macro view_xcenter_right view_x + view_width/2


function mouse_dx_values(){
	if (mouse_click){
		mouse_x_previous=mouse_x;
		mouse_y_previous=mouse_y;
	} 
	mouse_dx = (mouse_x-mouse_x_previous);
	mouse_dy = (mouse_y-mouse_y_previous);
	
}

function mouse_previous_values(){
	mouse_x_previous = mouse_x;
	mouse_y_previous = mouse_y;
}

function mouse_previous_values_and_moved(){
	mouse_moved = (mouse_x != mouse_x_previous) && (mouse_y != mouse_y_previous);
	mouse_previous_values();
}
	
function mouse_wheel_value(){
	if mouse_wheel_up() return 1;
	if mouse_wheel_down() return -1;
	return 0;
}

function draw_sprite_ext_default(_spr=sprite_index,_img=image_index,
									_x=x,_y=y,_xs=image_xscale,_ys=image_yscale,
									_ang=image_angle,_blend=image_blend,_alpha=image_alpha){
	draw_sprite_ext(_spr,_img,_x,_y,_xs,_ys,_ang,_blend,_alpha);
}

global.call_n_array = []
function call_n(period,callback,args=[],reps=0,unit=time_source_units_seconds){
	var time_source = time_source_create(time_source_game,period,unit,callback,args,reps);
	time_source_start(time_source);
	array_push(global.call_n_array,time_source);
	return time_source;
}

function call_for(time_calling,period,callback,args=[],unit=time_source_units_seconds){
	var calls = floor(time_calling/period);
	return call_n(period,callback,args,calls,unit);
}

function call_n_clear(){
	while(array_length(global.call_n_array) > 0){
		var time_source = array_pop(global.call_n_array);
		if (time_source_exists(time_source))
			time_source_destroy(time_source);
	}
}
	
	
function setPos(xx = room_width/2, yy = room_height/2){
	x = xx;
	y = yy;
	phy_position_x = xx;
	phy_position_y = yy;
}

function setSpeed(vx=0,vy=0){
	phy_speed_x = vx;
	phy_speed_y = vy;
}


global.screen_shake_forca=0;
function screen_shake_cat_pos(){
	

	global.screen_shake_forca*=.8;	
	var _f = global.screen_shake_forca;
	view_pos(random_d(_f),random_d(_f));
}

function screen_shake_cat_forca(_f=10){
	global.screen_shake_forca=_f;
}


global.screen_shake = 0;
function screen_shake_once(_strength){
	if (global.screen_shake <= 0){
		global.screen_shake = _strength;
		call_to_screen_shake_once();
	}
}


function call_to_screen_shake_once(){
	var off_x = -164;
	global.screen_shake*=0.9;
	if (global.screen_shake < .5){
		global.screen_shake = 0;
	} else {
		var _f = global.screen_shake;
		view_pos(off_x+random_d(_f),random_d(_f));	
	}
	if (global.screen_shake>0){
		call_later(1,time_source_units_frames,call_to_screen_shake_once);
	}
}

function screen_shake(d) {
	view_pos(view_xview+random_d(d),view_yview+random_d(d));
}
global.screen_shake = 0;
function camera_pos_0() {
	view_pos(0+random_d(global.screen_shake),0+random_d(global.screen_shake));
	global.screen_shake*=.9;
}

function view_activate(){
	//instance_deactivate_object(SPAWNS);
	instance_activate_region(view_x,view_y,view_width,view_height,1);
}

function view_activate_inside(){
	instance_activate_region(view_x,view_y,view_width,view_height,1);
}

function layer_get_background(name){
	var lay = layer_get_id(name);
	var bg = layer_background_get_id(lay);
	return bg;
}

function alarm_val(i, val) {
	if (alarm[i] < 0) 
		alarm[i] = val;
}

function get_absolute_max_with_sign(argument0, argument1) {
	if abs(argument0) > abs(argument1)
		return argument1;
	return argument0;
}

function array_copia(ar) {
	var a = [];
	for(var i = 0; i<array_length(ar);i++)
		a[i] = ar[i];
	return a;
}

function array_find_value(ar, val) {
	var i = 0;
	repeat(array_length(ar)){
		if (ar[i] == val)
			return i;
		i++;
	}
	return -1;
}

function index_inside_array_range(ar,i){
	return (i>=0 && i<array_length(ar));
}

function asset_exists(asset) {
	return asset_get_index(asset) != -1;
}

function buffer_to_surface(buffer, s) {
	var w = surface_get_width(s);
	var h = surface_get_height(s);

	var surf = surface_create(w,h);
		//buffer_set_surface(buf,surf,0,0,0);
		surface_copy(s,0,0,surf);

	surface_free(surf);
	buffer_delete(buf);
}

function surface_to_buffer(surf) {
	var w = surface_get_width(surf);
	var h = surface_get_height(surf);
	var buf = buffer_create(w*h*4,buffer_fixed,1); 
		buffer_get_surface(buf,surf,0);
	return buf;
}


function circular(pos, final, initial = 0) {
	if (pos < 0){
		pos = abs(pos mod (final));
		pos = final - pos;
	}
	return abs(pos mod (final));
}
function array_index_from_value(_value,_array){
	for(var _i = 0; _i<array_length(_array);_i++){
		if _array[_i] == _value{
			return _i;
		}
	}
	return 0;
}

function circular_array_by_value(_value,_array,_add=+1){
	var _pos = array_index_from_value(_value,_array);
	_pos = circular_array(_pos+_add,_array);
	return _array[_pos];
}

function circular_array(pos,array){
	return circular(pos,array_length(array));
}

function singleton(obj = object_index) {
	if (!instance_exists(obj)){
		return instance_create_depth(0,0,0,obj);
	} 
	return obj.id;
}
function singleton_me(){
	if (instance_number(object_index) > 1){
		instance_destroy();
		return 0;
	}
	return 1;
}

function ds_list_contains(ds,value) {
	return ds_list_find_index(ds,value) == -1;
}

function string_trim(word) {
	var initial = 1;
	var final = 1;
	var foundInitial = 0;
	var foundFinal = 0;
	for(var i = 1; i <= string_length(word); i++){
		if (!foundInitial){
			if (string_char_at(word,i) != " "){
				foundInitial = 1;
			}
			initial = i;
		}
	}

	for(var i = string_length(word); i >= 1; i--){
		if (!foundFinal){
			if (string_char_at(word,i) != " "){
				foundFinal = 1;
			}
			final = i;
		}
	}
	var word_trimmed = string_copy(word,initial,final);
	return word_trimmed;
}


function areEquals(a, b) {
	if (is_array(a) && is_array(b))
		return array_equals(a,b);

	if (is_array(a) || is_array(b))
		return false;
		
		return a == b;
}

///@param [v1,v2,v3],v4
function array_build_from_values() {
	var a = [];
	var i = 0;
	var k = 0;
	repeat(argument_count){
		var v = argument[k++];
		if is_array(v){
			var j = 0;
			repeat(array_length(v)){
				a[i++] = v[j++];
			}
		} else {
			a[i++] = v;
		}
	}
	return a;
}

function random_dice(val) {
	return irandom(val) == 0;
}

function random_dado(_chance) {
	return irandom(_chance) == 0;
}
function random_percentage(_val) {
	return random(1) <= _val;
}
function random_pct(_val) {
	return random_percentage(_val) 
}

function random_chance(chance){
	if (random(100)<=chance) return 1;
	return 0;
}

function random_d(_x){
	return random_range(-_x,_x);
}

function toggle_ip(ds, ip) {
	var i = 0;
	repeat(ds_list_size(ds)){
		if (ds[| i] == ip){
			ds_list_delete(ds,i);
			return true;
		}
		i++;
	}
	ds_list_add(ds,ip);
	return false;
}

function char_to_value(char) {
	switch(char){
		case "0": return 0;
		case "1": return 1;
		case "2": return 2;
		case "3": return 3;
		case "4": return 4;
		case "5": return 5;
		case "6": return 6;
		case "7": return 7;
		case "8": return 8;
		case "9": return 9;
		case "a": case "A": return 10;
		case "b": case "B": return 11;
		case "c": case "C": return 12;
		case "d": case "D": return 13;
		case "e": case "E": return 14;
		case "f": case "F": return 15;
		default: return 0;
	}
}

function split_get_next(sep = " ") {
	//uses str
	var len = string_length(sep)-1;
	var cnt = string_count(sep,str);
	
	if (cnt == 0) {
		var r = str; 
		str = ""; 
		return r;
	}
    
	var pos = string_pos(sep,str);
	return string_copy(str,1,pos-1);
}

function string_split_get_next(str, sep = " ") {
	    len = string_length(sep)-1;
    
	    cnt = string_count(sep,str);
	    if (cnt == 0){var r = str; str = ""; return r;}
    
	    var pos = string_pos(sep,str);
	    return string_copy(str,1,pos-1);
}


function split_next(sep = " ") {
	//setar str;
	    len = string_length(sep)-1;
    
	    cnt = string_count(sep,str);
	    if (cnt == 0){var r = str; str = ""; return r;}
    
	    var pos = string_pos(sep,str);
	    var retorno = string_copy(str,1,pos-1);
	        str = string_delete(str,1,pos);
	    return retorno;
}


function char_next() {
	//setar str;
	if (str == "") return "";
	
	var char = string_char_at(str,1);
	    str = string_delete(str,1,1);
	return char;
}

function string_apaga_linha(_str, max_linhas) {

	//remove ocorrências antigas
		var cnt = string_count("\n",_str);
		var rep = cnt-max_linhas;
		if (rep<0){return _str;}
			str = _str;
			repeat(rep){split_next("\n");}
		return str;
}

function string_contains(substr, str) {
	return string_pos(substr,str)>0;
}

function string_find_between(str, d1, d2) {
	
	var pos = string_pos(d1,str);
	var posOffset = pos+string_length(d1);
	var fim = string_pos(d2,str);
	var fimOffset = fim+string_length(d2);
	var tam = fimOffset-pos;
	var s1 = string_delete(str,pos,tam);
	var s2 = string_copy(str,pos,tam);
		s2 = string_replace(s2,d1,"");
		s2 = string_replace(s2,d2,"");
	
	return [s1,s2];
}

function string_split_next(str,sep,get_next) {
	len = string_length(sep)-1;
	cnt = string_count(sep,str);
	if (cnt == 0){return str;}
    
	var pos = string_pos(sep,str);
    
	if (get_next)
		return string_delete(str,1,pos);
	
	return string_copy(str,1,pos-1);
}


function string_typing_effect(str) {
	var b = "|";
	if floor(current_time/400) % 2 == 0{b = "";}
	return str+b;
}

function string_typing_effect_bar() {
	var b = "|";
	if floor(current_time/400) % 2 == 0{b = "";}
	return b;
}

function ini_save_escreve_valor(section,key,value,file = "save.ini") {
	ini_open(file);
		if (!is_string(value)){
			ini_write_real(section,key,value);
		} else {
			ini_write_string(section,key,value);
		}
	ini_close();
}

function ini_save_le_valor(section,key,file = "save.ini", _default=0) {
	ini_open(file);
	    var val = ini_read_real(section,key,_default);
	ini_close();
	return val;
}

function ini_save_le_string(section,key,file = "save.ini",_default="0") {
	ini_open(file);
	    var val = ini_read_string(section,key,_default);
	ini_close();
	return val;
}

function angle_difference_mov(source, dest, vel) {
	    var dif = angle_difference(source,dest);
	    return sign(dif)*min(abs(dif),abs(vel));
}

function angle_difference_mov_special(source, dest, fator) {
	return angle_difference(source,dest)/fator;
}

function mouse_gui_in_rectangle(x1, y1, x2, y2) {
	return point_in_rectangle(	device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),
								x1,y1,
								x2,y2);
}

function mouse_in_rectangle(x1, y1, x2, y2) {
	return point_in_rectangle(	mouse_x,mouse_y,
								x1,y1,
								x2,y2);
}

function mouse_in_rectangle2(px, py, w, h) {
	return point_in_rectangle(mouse_x,mouse_y,px-1,py,px+w+1,py+h);
}

function point_direction_object(to,from=id,ox=0,oy=0){
	if (instance_exists(to) && instance_exists(from) ) {
		return point_direction(from.x,from.y,to.x+ox,to.y+oy);
	}
	return 0;
}

function point_direction_vector(vx,vy){
	return point_direction(0,0,vx,vy);
}

function point_distance_vector(vx,vy){
	return point_distance(0,0,vx,vy);
}

function point_distance_object(to,from=id,ox=0,oy=0){
	if (instance_exists(to) && instance_exists(from) ) {
		return point_distance(from.x,from.y,to.x+ox,to.y+oy);
	}
	return 0;
}

function follow_me(_obj,_ox=0,_oy=0,_me=id){
	with(_obj){
		x = _me.x+_ox;
		y = _me.y+_oy;
	}
}

function wave_function(_minimo=0,_maximo=1,_ms_time=1000){
	var _middle = (_minimo+_maximo)/2;
	var _wave_len = (_maximo-_minimo)/2;
	return wave_function_middle(_middle,_wave_len,_ms_time)
}

function wave_function_middle(_middle=.5,_wave_len=1,_ms_time=1000){
	var _value = (current_time % _ms_time)*360/_ms_time;
	return (_middle) + dcos(_value)*_wave_len;
}

function collision_line_point(x1,y1,x2,y2,obj,precision,notme){
	var instance, ix, iy,_dx,_dy;
	instance = collision_line(x1, y1, x2, y2, obj, precision, notme);
	var _initial_x = x1;
	var _initial_y = y1;
	var _final_x = x2;
	var _final_y = y2;
	
	ix = x2;
	iy = y2;
	if (instance != noone) {
	    var p0 = 0;
	    var p1 = 1;
	    repeat (ceil(log2(point_distance(x1, y1, x2, y2))) + 1) {
	        var np = p0 + (p1 - p0) * 0.5;
	        var nx = x1 + (x2 - x1) * np;
	        var ny = y1 + (y2 - y1) * np;
	        var px = x1 + (x2 - x1) * p0;
	        var py = y1 + (y2 - y1) * p0;
	        var nr = collision_line(px, py, nx, ny, obj, precision, notme);
	        if (nr != noone) {
	            instance = nr;
	            ix = nx;
	            iy = ny;
	            p1 = np;
	        } else p0 = np;
	    }
	}
	
	_final_x		= ix;
	_final_y		= iy;
	var _dx			= _final_x-_initial_x;
	var _dy			= _final_y-_initial_y;
	var _size		= point_distance(_initial_x,_initial_y,_final_x,_final_y);
	var _direction	= point_direction(_initial_x,_initial_y,_final_x,_final_y);
	return [instance,_initial_x,_initial_y,_final_x,_final_y,_dx,_dy,_size,_direction]; 
}


function draw_laser(_ix=x,_iy=y,_fx=x,_fy=y+1000,_spr=spr_laser,_w=16,_uspd=0,_vspd=0,_collision_with = noone){
	var _tex = sprite_get_texture(_spr,0);
	var _tw = texture_get_texel_width(_tex);
	var _th = texture_get_texel_height(_tex);
	
	var _dir = point_direction(_ix,_iy,_fx,_fy);
	var _dis = point_distance( _ix,_iy,_fx,_fy);
	var _u = 0;
	var _v = 0;
	if (_uspd!=0){
		_u+=current_time*_tw*_uspd*.001*60;
	}
	if (_vspd!=0){
		_v+=current_time*_th*_vspd*.001*60;
	}
	
	_w*=.5;
	draw_set_colour(c_white);
	draw_primitive_begin_texture(pr_trianglestrip,_tex);
		var _dir2 = _dir + 90;
		var _lx = lengthdir_x(_w,_dir2);
		var _ly = lengthdir_y(_w,_dir2);
	
	
		var _x1 = _ix-_lx;
		var _x2 = _ix+_lx;
		var _x3 = _fx-_lx;
		var _x4 = _fx+_lx;
	
		var _y1 = _iy-_ly;
		var _y2 = _iy+_ly;
		var _y3 = _fy-_ly;
		var _y4 = _fy+_ly;
	
		var _pw = _w*2*_tw;
		var _ph = _dis*_th;
		
		draw_vertex_texture(_x1,_y1,	_u+0,	_v+000);
		draw_vertex_texture(_x2,_y2,	_u+_pw,	_v+000);
		draw_vertex_texture(_x3,_y3,	_u+0,	_v+_ph);
		draw_vertex_texture(_x4,_y4,	_u+_pw,	_v+_ph);
	draw_primitive_end();
	
	var _cria = instance_create_depth(_x2,_y1,-1000,obj_hitbox,
										{	
											image_xscale:_dis,
											image_yscale:_w*2,
											image_angle:_dir,
											image_alpha:0,
											visible:0
										}
									);
									
	var _collision_team = collision_team;
	var _id = id;
	with(_cria){
		image_xscale*=1.3;
		image_yscale*=1.3;
		x+=_lx*.3;
		y+=_ly*.3;
		pai = _id;
		collision_with = _collision_with;
		collision_team = _collision_team
	}
		
}


function draw_texture_walking(_x1=x,_y1=y,_x2=x+32,_y2=y+32,_spr=spr_laser,_img=0,_uspd=0,_vspd=0,_blend=c_white,_alpha=1){
	var _tex = sprite_get_texture(_spr,_img);
	var _tw = texture_get_texel_width(_tex);
	var _th = texture_get_texel_height(_tex);
	
	var _u = 0;
	var _v = 0;
	if (_uspd!=0){
		_u+=current_time*_tw*_uspd*.001*60;
	}
	if (_vspd!=0){
		_v+=current_time*_th*_vspd*.001*60;
	}
	
	draw_set_colour(c_white);
	draw_primitive_begin_texture(pr_trianglestrip,_tex);
		var _pw = (_x2-_x1)*_tw;
		var _ph = (_y2-_y1)*_th;
		draw_vertex_texture_color(_x1,_y1,	_u+0,	_v+000,_blend,_alpha);
		draw_vertex_texture_color(_x2,_y1,	_u+_pw,	_v+000,_blend,_alpha);
		draw_vertex_texture_color(_x1,_y2,	_u+0,	_v+_ph,_blend,_alpha);
		draw_vertex_texture_color(_x2,_y2,	_u+_pw,	_v+_ph,_blend,_alpha);
	draw_primitive_end();
}

function draw_rectangle_cooldown(x1,y1,x2,y2,color,alpha,value){

	var xm, ym, vd, vx, vy, vl;
	if (value <= 0) return 0; // nothing to be drawn
	if (value >= 1) {
		draw_rectangle(x1, y1, x2, y2, false) // entirely filled
		return 0;
	}
	xm = (x1 + x2) / 2; ym = (y1 + y2) / 2; // middle point
	draw_primitive_begin(pr_trianglefan)
		draw_vertex_color(xm, ym,color,alpha); 
		draw_vertex_color(xm, y1,color,alpha)
		// draw corners:
		if (value >= 0.125) draw_vertex_color(x2, y1,color,alpha)
		if (value >= 0.375) draw_vertex_color(x2, y2,color,alpha)
		if (value >= 0.625) draw_vertex_color(x1, y2,color,alpha)
		if (value >= 0.875) draw_vertex_color(x1, y1,color,alpha)
		// calculate angle & vector from value:
		vd = pi * (value * 2 - 0.5)
		vx = cos(vd)
		vy = sin(vd)
		// normalize the vector, so it hits -1+1 at either side:
		vl = max(abs(vx), abs(vy))
		if (vl < 1) {
		    vx /= vl
		    vy /= vl
		}
		draw_vertex_color(xm + vx * (x2 - x1) / 2, ym + vy * (y2 - y1) / 2,color,alpha)
	draw_primitive_end()
}

function draw_rectangle_cooldown_texture(x1,y1,x2,y2,color,alpha,sprite,img,value){
	var xm, ym, vd, vx, vy, vl;
	if (value <= 0) return 0 // nothing to be drawn
	if (value >= 1) { 
		draw_sprite(sprite,img,x1, y1); // entirely filled
		return 0;
		
	}
	xm = (x1 + x2) / 2; ym = (y1 + y2) / 2; // middle point
	var tex = sprite_get_texture(sprite,img);
	var tw = 1/sprite_get_width(sprite);
	var th = 1/sprite_get_height(sprite);
	
	draw_primitive_begin_texture(pr_trianglefan,tex)
		draw_vertex_texture_color(xm, ym,.5,.5,color,alpha); 
		draw_vertex_texture_color(xm, y1,.5,0,color,alpha)
		// draw corners:
		if (value >= 0.125) draw_vertex_texture_color(x2, y1,1,0,color,alpha)
		if (value >= 0.375) draw_vertex_texture_color(x2, y2,1,1,color,alpha)
		if (value >= 0.625) draw_vertex_texture_color(x1, y2,0,1,color,alpha)
		if (value >= 0.875) draw_vertex_texture_color(x1, y1,0,0,color,alpha)
		// calculate angle & vector from value:
		vd = pi * (value * 2 - 0.5)
		vx = cos(vd)
		vy = sin(vd)
		// normalize the vector, so it hits -1+1 at either side:
		vl = max(abs(vx), abs(vy))
		if (vl < 1) {
		    vx /= vl
		    vy /= vl
		}
		var px = xm + vx * (x2 - x1) / 2;
		var py =  ym + vy * (y2 - y1) / 2;
		draw_vertex_texture_color(px,py,.5 + (px-xm)*tw,.5 + (py-ym)*th,color,alpha);
	draw_primitive_end()
}

function draw_sprite_cooldown(xx,yy,spr,img,value){
	var sw = sprite_get_width(spr);
	var sh = sprite_get_height(spr);
	draw_sprite_ext(spr,img,xx,yy,1,1,0,c_dkgray,1);
	draw_rectangle_cooldown_texture(xx,yy,xx+sw,yy+sh,c_white,1,spr,img,value);
}


function draw_sprite_mask(_spr=sprite_index,_img=image_index,_xx=x,_yy=y,_xs=image_xscale,_ys=image_yscale,_ang=image_angle,_color=image_blend,_alpha=image_alpha){
	gpu_set_fog(1,_color,0,0);
		draw_sprite_ext(_spr,_img,_xx,_yy,_xs,_ys,_ang,c_white,_alpha);
	gpu_set_fog(0,0,0,c_white);
}

function draw_self_outlined(_offset = 6, _outline_color=c_white, _x=x,_y=y,_spr=sprite_index,_img=image_index,_xs = image_xscale,_ys = image_yscale,_ang = image_angle,_blend=image_blend,_alpha = image_alpha){
	if (_offset > 0) {
		gpu_set_fog(1,_outline_color,0,0);
		for (var _ox = -_offset; _ox <= _offset; _ox += _offset) {  
		     for (var _oy = -_offset; _oy <= _offset; _oy += _offset) {  
		          draw_sprite_ext(_spr,_img,_x+_ox,_y+_oy,_xs,_ys,_ang,_blend,_alpha);
		     }
		}
		gpu_set_fog(0,0,0,c_white);
	}
	draw_self();
}


function draw_sprite_mask_color(color = c_white,alpha=1){
	draw_sprite_mask(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,color,alpha);
}

function rastro_mask_create(spr=sprite_index,img=image_index,_depth = depth+1,xx=x,yy=y,xs=image_xscale,ys=image_yscale,ang=image_angle,color=image_blend,alpha=1){
	var cria = instance_create_depth(xx,yy,_depth,obj_rastro_mask);
	with(cria){
		sprite_index = spr;
		image_index = img;
		image_speed = 0;
		image_xscale = xs;
		image_yscale = ys;
		image_angle = ang;
		image_blend = color;
		image_alpha = alpha;
	}
	return cria;
}


function tentaculo_create(obj = obj_tentaculo, spr = spr_sakura_cabelo, depth = -10, qtd = 3,tamanho=12, _pai = id , xx =x ,yy = y){
	var img = 0;
	var cria = instance_create_depth(xx,yy,depth,obj);
		cria.pai = _pai;
		cria.size = tamanho;
		cria.tipo = 0;
		cria.sprite_index = spr_sakura_cabelo;
		cria.image_index = 0;
		cria.first = 1;
		
	var previous = cria;
	repeat(qtd){
		
		var next = instance_create_depth(xx,yy,depth,obj);
			next.pai = previous;
			next.size = tamanho;
			next.tipo = 1;
			next.sprite_index = spr_sakura_cabelo;
			next.image_index = 1;
		previous.filho = next;	
		previous = next;
	}
	next.sprite_index = spr_sakura_cabelo;
	next.image_index = 2;
	return cria;
}

function muzzle_create(spr = spr_muzzle_flash, _dir = image_angle,_ox = 0, _oy = 0){
	variable_init_if_not("_muzzle", -1);
	
	if (_muzzle == -1 || !instance_exists(_muzzle)){ 
		var cria = muzzle_create_multiple(spr,_dir,_ox, _oy);
		_muzzle = cria;
		return cria;
	}
	return noone;
}


function muzzle_create_multiple(spr = spr_muzzle_flash, _dir = image_angle,_ox = 0, _oy = 0, xs=1, ys=1){
	var cria = instance_create_depth(x,y,depth,obj_muzzle_flash);
	with(cria){
		pai = other;
		ox = _ox;
		oy = _oy;
		image_angle = _dir;
		sprite_index = spr;
		image_xscale = xs;
		image_yscale = ys;
	}
	return cria;
}


function instance_create(obj,_x = 0, _y = 0, _depth = 0){
	return instance_create_depth(_x,_y,_depth,obj);
}

function instance_create_layer_same(_x,_y,obj){
	return instance_create_layer(_x,_y,layer,obj);
}

function each_frames_once(_wait_frames=1){
	var _exists_value = variable_instance_exists(id,"__frames");
	if ((!_exists_value) || __frames > _wait_frames){
		__frames = 0;
		return 1;
	}
	__frames++;
	return 0;
}


function each_milliseconds(milliseconds){
	if floor(current_time/(milliseconds*.5)) mod 2{
		return 1;
	}
	return 0;
}


function each_milliseconds_once(milliseconds, val = "_mil_time"){
	if (!variable_instance_exists(id,val) || (current_time > _mil_time + milliseconds)){
		variable_instance_set(id,val,current_time);
		return 1;
	}
	return 0;
}

function variable_init_if_not(var_name,val = -1){
	if !variable_instance_exists(id,var_name){
		variable_instance_set(id,var_name,val);
	}
}

function variable_exists(val_name){
	return variable_instance_exists(id,val_name);
}

function constructor_draw_grid(grid_size=32){
	draw_set_alpha(.4);
	draw_set_colour(c_lime);
	
	//vertical lines
	var yy = view_y;
	repeat(ceil(view_height/grid_size)){
		draw_line(view_x,yy,view_xborder,yy);
		yy+=grid_size
	}


	//horizontal lines
	var xx = view_x;
	repeat(ceil(view_width/grid_size)){
		draw_line(xx,view_y,xx,view_yborder);
		xx+=grid_size;
	}

	draw_set_alpha(1);
}


function constructor_draw_object_select(grid_size){
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fnt_default);
	var xx = view_x+10;
	var yy = view_y+10;
	var w = grid_size;
	var h = grid_size;
	for(var i = 0; i < array_length(objs); i++){
		var obj = objs[i];
		var spr = object_get_sprite(obj);
		var name = object_get_name(obj);
		if (filter != "" && objs_i != i){
			if (!string_contains(filter,name)){
				continue;
			}
		}
	
		draw_set_colour(c_lime);
		if (objs_i == i){
			draw_rectangle(xx,yy,xx+w,yy+h,0);
		}
	
		draw_sprite_stretched(spr,i,xx,yy,w,h);
	
		if (objs_i == i){
			draw_rectangle(xx,yy,xx+w,yy+h,1);
			draw_text_outline(xx,yy+h,name);
		}
	
		if (point_in_rectangle(mouse_x,mouse_y,xx,yy,xx+w,yy+h)){
			draw_set_alpha(.5);
			draw_set_colour(c_dkgray)
			draw_rectangle(xx,yy,xx+w,yy+h,false);	
			draw_set_alpha(1);
			if (mouse_any_click){
				objs_i = i;
			}
		}
		xx += w + 8;
	}
	if mouse_wheel_up(){objs_i++;}
	if mouse_wheel_down(){objs_i--;}
	objs_i = circular(objs_i,array_length(objs)-1);
	if (ctrl_clicking){
		if keyboard_check_pressed(ord("F")){
			filter = get_string("Buscando pelo que?","INIMIGO");
		}
	}
	if (mouse_click){
		filter = "";
	}
}

function draw_set_align(_halign,_valign){
	draw_set_halign(_halign);
	draw_set_valign(_valign);
}

function draw_set_font_align(_halign,_valign){
	draw_set_align(_halign,_valign);
}
function font_set_align(_halign,_valign){
	draw_set_align(_halign,_valign);
}

function draw_set_align_top_left(){
	draw_set_align(fa_left,fa_right);
}
function draw_set_align_middle_center(){
	draw_set_align(fa_middle,fa_center);
}

function controles_restart() {
	if keyboard_check_pressed(ord("R")){room_restart();}
}

function controles_fullscreen() {
	if keyboard_check_pressed(ord("F")){
		fullscreen_toggle();
		res_changed = 1;
	}
}

function draw_text_outline(_x,_y,str,c_in=c_white,c_out=c_black){
	draw_set_color(c_out);
		draw_text(_x+1,_y,str);
		draw_text(_x-1,_y,str);
		draw_text(_x,_y+1,str);
		draw_text(_x,_y-1,str);
	
	draw_set_colour(c_in);
		draw_text(_x,_y,str);
}


function draw_text_outline_transformed(_x,_y,str,xs=1,ys=1,angle=0,c_in=c_white,c_out=c_black){
	draw_set_color(c_out);
		draw_text_transformed(_x+1,_y,str,xs,ys,angle);
		draw_text_transformed(_x-1,_y,str,xs,ys,angle);
		draw_text_transformed(_x,_y+1,str,xs,ys,angle);
		draw_text_transformed(_x,_y-1,str,xs,ys,angle);
	
	draw_set_colour(c_in);
		draw_text_transformed(_x,_y,str,xs,ys,angle);
}

function draw_text_outline_colour(_x,_y,str,c1=c_white,c2=c_white,c3=c_white,c4=c_white,c_out=c_black){
	draw_set_color(c_out);
		draw_text(_x+1,_y,str);
		draw_text(_x-1,_y,str);
		draw_text(_x,_y+1,str);
		draw_text(_x,_y-1,str);
	draw_text_colour(_x,_y,str,c1,c2,c3,c4,1);
}

#region audio
	//default is for sfx
	
	function sound_play(_snd,_vol=global.volume_sfx,_pitch=1,_multiple=1,_loops=0,_priority=1){
		switch(_multiple){
			case 0: //cant play multiple
				if (audio_is_playing(_snd)){
					return _snd;// todo(tumais) - tratar melhor esse erro
				}
			break;
			
			case 1://can play multiple
			break;
			
			case 2://overlap
				if (audio_is_playing(_snd)) {
					audio_stop_sound(_snd);
				}
			break;
		}
		
		var snd = audio_play_sound(_snd,_priority,_loops,_vol,0,_pitch);
		return snd;
	}
#endregion


#region options
	global.volume_sfx = 1;
	global.volume_master = 1;
	global.volume_music = 1;
	
	function options_ini_init(){
		ini_open("cfg.ini");
			global.volume_master = ini_read_real("cfg","master",1);
			global.volume_music = ini_read_real("cfg","music",1);
			global.volume_sfx = ini_read_real("cfg","sfx",1);
		ini_close();
		audio_master_gain(global.volume_master);
	}
	
	function options_draw(xx=100,yy=100){
		draw_set_font(fa_highscore);
		zbar_changed = 0;
		var previous_volume_master = global.volume_master;
		var previous_volume_music = global.volume_music;
		var previous_volume_sfx = global.volume_sfx;
		
		var master_text = "Master: " + string(global.volume_master*100) + "%";
		var music_text = "music: " + string(global.volume_music*100) + "%";
		var sfx_text = "sfx: " + string(global.volume_sfx*100) + "%";
		global.volume_master = options_bar(xx,yy,master_text,200,20,global.volume_master);
		global.volume_music = options_bar(xx,yy+40,music_text,200,20,global.volume_music);
		global.volume_sfx = options_bar(xx,yy+80,sfx_text,200,20,global.volume_sfx);
		
		if options_button(xx,yy+120,"Menu",200,20){
			room_goto(rm_sakura_intro);
		}
		
		if options_button(xx,yy+152,"Tate: " + string(global.tate),200,20){
			global.tate++;
			if (global.tate>2) {
				global.tate = 0;
			}
		}
		if options_button(xx,yy+192,"CRT: " + string(global.crt),200,20){
			global.crt = !global.crt;
		}
		if (zbar_changed){
			ini_open("cfg.ini");
				ini_write_real("cfg","master",global.volume_master);
				ini_write_real("cfg","music", global.volume_music);
				ini_write_real("cfg","sfx",   global.volume_sfx);
			ini_close();
			console("saved")
			audio_master_gain(global.volume_master);
		}
	}

#endregion

#region UI
	function options_bar(_x, _y, _str, _w, _h, value, mx=mouse_x, my=mouse_y, padding=0) {
		var vw = lerp(0,_w,value);
		var sw = max(0,_w);
		var sh = max(string_height(_str),_h);
		var color = c_black;
		var rl = floor(_x-padding);//rectangle left point
		var rr = floor(_x+padding+sw);//rectangle right point
		var rt = floor(_y-padding);
		var rb = floor(_y+sh+padding);
		if (mx > rl && mx < rr){
			if (my > rt) && (my < rb){
				color = c_white;
				if (mouse_clicking){
					zbar_changed = 1;
					vw = (mx-_x);
					value = vw/_w;
				}
			}
		}
		
		draw_set_font_align(fa_middle,fa_center);
		var _psw = _x + sw/2;
		var _psh = _y + sh/2;
		
		draw_set_colour(c_dkgray);
			draw_rectangle(rl,rt,rr,rb,0);
		draw_set_colour(merge_colour(c_red,c_lime,value));
			draw_rectangle(rl,rt,rl+vw,rb,0);
		draw_set_colour(color);
			draw_rectangle(rl,rt,rr,rb,1);
		draw_text_outline(_psw,_psh,_str,c_white,c_black);
		
		return ceil(value*100)/100;
	}
	
	function options_button(_x, _y, _str, _w, _h, mx=mouse_x, my=mouse_y, padding = 0){
		var value = 0;
		var _colour = c_white;
		if point_in_rectangle(mx,my,_x,_y,_x+_w,_y+_h){
			_colour = c_gray;
			if (mouse_clicking){
				_colour = c_dkgray;
			}
			if (mouse_released) {
				value = 1;
			}
		}
		draw_set_colour(_colour);
			draw_rectangle(_x,_y,_x+_w,_y+_h,0); 
		font_set_align(fa_center,fa_middle);
			draw_text_outline(_x+_w/2,_y+_h/2,_str,c_black,c_white);
		draw_set_colour(c_white);
		return value;
	}


	function draw_bar(px=10,py=10,w=100,h=5,value=100,value_max=100,bgcolor=c_dkgray,barcolor=c_aqua){
		var val = (value/value_max);
		draw_set_color(bgcolor);
		draw_rectangle_size(px,py,w,h,0);

		draw_set_color(barcolor);
		draw_rectangle_size(px,py,val*w,h,0);

		draw_set_color(c_black);
		draw_rectangle_size(px,py,w,h,1);
	}
	
	function draw_bar_centered(_x, _y, _w, _h, _value,_max_value=1,bgcolor=c_dkgray,barcolor=c_aqua){
		draw_bar(_x-_w/2, _y-_h/2, _w, _h, _value,_max_value,bgcolor,barcolor);
	}
#endregion

function draw_self_mask(_colour){
	gpu_set_fog(1,_colour,0,0);
		draw_self();
	gpu_set_fog(0,_colour,0,0);
}

function draw_sprite_ext_mask(_color=c_white,_sprite=sprite_index,_img=image_index,_x=x,_y=y,_xs=image_xscale,_ys=image_yscale,_rot=image_angle,_alpha=image_alpha){
	gpu_set_fog(1,_color,0,0);
		draw_sprite_ext(_sprite,_img,_x,_y,_xs,_ys,_rot,_color,_alpha);
	gpu_set_fog(0,_color,0,0);
}


global.enemy_id = 0;
global.debug = 0;