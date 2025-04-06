enum ExtendingState {
	None = 0,
	Extending = 1,
	Retracting = 2
}

global.collected_crystals = 0

function on_collided(interactable) {
	if !holding {
		if interactable.object_index == Crystals {
			earthquake = layer_get_id("Earthquake")
			fx = layer_get_fx(earthquake)
			fx_set_parameter(fx, "g_Magnitude", 5)
			fx_set_parameter(fx, "g_ShakeSpeed", 1.25)
			alarm_set(0, 1 * game_get_speed(gamespeed_fps))

			for(i = 0; i < random_range(14, 20); i++) {
				yPosition = Player.y - camera_get_view_height(1)/2 - 20 + random(5)
				xPosition = Player.x - random_range(-camera_get_view_width(1)/2 - 5, camera_get_view_width(1)/2 - 5)
				instance_create_layer(xPosition, yPosition, "Instances", FallingRock)
			}
			global.collected_crystals += 1
			instance_destroy(interactable.id)
		}
	} else {

	}

	
}

function on_dropped() {
	if !holding {
		show_error("on_dropped called when nothing is being held", false)
		return	
	}

}

function get_player_position() {
	return [Player.x + 4, Player.y + 6]
}

function claw_extend() {
	var interactable_collided = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, Interactable, false, true)
	
	if interactable_collided {
		on_collided(interactable_collided)
		extending = ExtendingState.Retracting
	} else if extended_range >= max_extend_range {
		extending = ExtendingState.Retracting
	}
	else if place_meeting(x, y + 1, MainLevel) {
		extending = ExtendingState.Retracting
		
		on_dropped()
	}
	else {
		y += 1
		extended_range += 1
	}
	
	if extending == ExtendingState.Retracting {
		alarm_set(1, claw_retract_speed * game_get_speed(gamespeed_fps)) 
	} else if  extending == ExtendingState.Extending {
		alarm_set(1, claw_extend_speed * game_get_speed(gamespeed_fps)) 
	}
}

function claw_retract() {
	if extended_range > 0 {
		y -= 1
		extended_range -= 1
		alarm_set(1, claw_retract_speed * game_get_speed(gamespeed_fps)) 
	} else {
		image_index = 0
		extending = ExtendingState.None
	}
}