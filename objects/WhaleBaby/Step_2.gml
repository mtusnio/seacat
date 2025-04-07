if follows {
	x = Player.x - 35
	y = Player.y - 7
	image_xscale = -Player.image_xscale
}


if distance_to_object(WhaleMother) < 25 {
	follows = false
	delivered = true
	
	x = WhaleMother.x + 24
	y = WhaleMother.y + 20
	WhaleMother.sprite_index = whale
	image_xscale = 1
	task_solved()
}