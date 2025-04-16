function isMoving() {
	if JumpX == 0 and JumpY == 0 {
		return false	
	}
	
	return x != JumpX and y != JumpY
}


var JUMP_TIME = 2.0
if isMoving() {
	var start_point = [ StartX, StartY ]
	var end_point = [ JumpX, JumpY ]
	var height_point = [ HeightX, HeightY ]
	var _dt = delta_time / 1000000;
	
	if (distance_to_point(JumpX, JumpY) > 0.5) {
		TravelTime += _dt
		var m1_x = lerp(start_point[0], height_point[0], TravelTime)
		var m2_x = lerp(height_point[0], end_point[0], TravelTime)
		var m1_y = lerp(start_point[1], height_point[1], TravelTime)
		var m2_y = lerp(height_point[1], end_point[1], TravelTime)

		x = lerp(m1_x, m2_x, TravelTime)
		y = lerp(m1_y, m2_y, TravelTime)
	
	} else {
		x = JumpX
		y = JumpY
	}
}