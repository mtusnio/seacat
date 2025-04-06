
if extended_range > 0 {
	var xOffset = 2
	draw_set_color(c_black)
	draw_line(get_player_position()[0] + xOffset, get_player_position()[1], x + xOffset, y)
}