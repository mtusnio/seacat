if follows {
	x = Player.x - 35
	y = Player.y - 7
	image_xscale = -Player.image_xscale
}


if distance_to_object(WhaleMother) < 70 {
	follows = false
	delivered = true
	task_solved()
}