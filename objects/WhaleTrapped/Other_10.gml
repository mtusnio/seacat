if !Released {
	var MOVE_DISTANCE = 85
	sprite_index = whale
	Ceiling = y - MOVE_DISTANCE
	image_speed = 3.0
	move_towards_point(x, Ceiling, 1)
}