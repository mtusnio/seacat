if global.ending {
	var _dt = delta_time / 1000000;

	global.fade = min(1.0, global.fade + _dt / 3.0)
	draw_set_colour(c_black);
	draw_set_alpha(global.fade);
	draw_rectangle(
		0,
		0,
		display_get_gui_width(),
		display_get_gui_height(),
		false
	)
}
