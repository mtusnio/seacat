if follows {
	x = Player.x - 30
	y = Player.y - 7
}

if distance_to_object(MotherWhale) < 150 {
	follows = false
	delivered = true
	task_solved()
}