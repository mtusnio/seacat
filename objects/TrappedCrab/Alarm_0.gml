
if !Saved {
	var REQUIRED_STACK_SIZE = 4
	var CRAB_DISTANCE = 50
	for (var i = 0; i < instance_number(Crab); ++i;)
	{
		var found_crab = instance_find(Crab,i);
		var stack_size = variable_instance_get(found_crab, "StackSize")
		show_debug_message("Crab stack: {0}", stack_size)

		if stack_size >= 3 {
			if distance_to_object(found_crab) <= CRAB_DISTANCE {
				show_debug_message("Crab stack found")
				Saved = true
				instance_destroy(id)
			}
		}
	}

	alarm_set(0, 2 * game_get_speed(gamespeed_fps)) 
}