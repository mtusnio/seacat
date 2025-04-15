if Ceiling != 0 {
	if y <= Ceiling {
		speed = 0
		return	
	}
	
	move_towards_point(x, Ceiling, 1)
}