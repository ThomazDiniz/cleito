direction++;
var _scale = 1 + dsin(direction)*.1;
image_angle = dsin(direction)*3
image_xscale=_scale;
image_yscale=_scale;
draw_self();

/*draw_set_colour(c_lime)
draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);