var _dt = delta_time / 1000000;

FadeInTimer = max(0.0, FadeInTimer - _dt / 4.0)
draw_set_colour(c_black);
draw_set_alpha(FadeInTimer);
draw_rectangle(
	0,
	0,
	display_get_gui_width(),
	display_get_gui_height(),
	false
)
