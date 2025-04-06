
if extended_range > 0 {
	var xOffset = -0.5
	
	if get_player_orientation() == -1 {
		xOffset = -1.5
	}
	
	var yOffset = -1
	draw_set_color($212125)
	draw_line_width(get_player_position()[0] + xOffset, get_player_position()[1] + yOffset, x + xOffset, y + yOffset, 1)
}