if !Saved {
	var REQUIRED_STACK_SIZE = 4
	var CRAB_DISTANCE = 50
	for (var i = 0; i < instance_number(Crab); ++i;)
	{
		var found_crab = instance_find(Crab,i);
		var stack_size = variable_instance_get(found_crab, "StackSize")

		if stack_size >= 3 {
			if distance_to_object(found_crab) <= CRAB_DISTANCE {
				Saved = true
				StartX = x
				StartY = y
				JumpX = found_crab.x
				JumpY = crab_head_y(found_crab)
				HeightX = (JumpX + StartX) / 2.0
				HeightY = StartY - 20.0
				sprite_index = crab
				break
			}
		}
	}

	alarm_set(0, 0.25 * game_get_speed(gamespeed_fps)) 
}