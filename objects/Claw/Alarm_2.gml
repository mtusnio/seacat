var MAX_SCRATCHES = 6

if x < Player.x {
	x = Player.x + 2
} else {
	x = Player.x - 2
}

show_debug_message("Scratch")

scratch_count += 1

if scratch_count < MAX_SCRATCHES {
	alarm_set(2, 0.2 * game_get_speed(gamespeed_fps))
} else {
	x = Player.x
	extending = ExtendingState.Retracting
	claw_retract()
}

