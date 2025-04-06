enum ExtendingState {
	None = 0,
	Extending = 1,
	Retracting = 2
}

global.collected_crystals = 0

/// @func on_collided(interactable)
/// @param {Id.Instance} interactable
function on_collided(interactable) {
	if !holding {
		if interactable.object_index == Crystal {
			global.collected_crystals += 1

			earthquake = layer_get_id("Earthquake")
			fx = layer_get_fx(earthquake)
			var crystals_multiplier = global.collected_crystals
			fx_set_parameter(fx, "g_Magnitude", 1 * crystals_multiplier)
			fx_set_parameter(fx, "g_ShakeSpeed", 0.9 * crystals_multiplier)
			alarm_set(0, 1 * game_get_speed(gamespeed_fps))

			for(i = 0; i < random_range(3 * crystals_multiplier, 7 * crystals_multiplier); i++) {
				yPosition = Player.y - camera_get_view_height(1)/2 - 20 + random(5)
				xPosition = Player.x - random_range(-camera_get_view_width(1)/2 - 5, camera_get_view_width(1)/2 - 5)
				instance_create_layer(xPosition, yPosition, "Instances", FallingRock)
			}
			instance_destroy(interactable.id)
		} else if interactable.object_index == WhaleItchy {
			if !WhaleItchy.Scratched {
				task_solved()
				WhaleItchy.Scratched = true
			}
		} else {
			if variable_instance_exists(interactable.id, "Pickable") and variable_instance_get(interactable.id, "Pickable") {
				holding = interactable.object_index
				instance_destroy(interactable.id)	
			}
		}
	} else {
		if interactable.object_index == OilSeep {
			if holding == OilRock {
				task_solved()
				created = instance_create_layer(interactable.x, interactable.y, "Instances", OilRock)
				variable_instance_set(created, "Pickable", false)
				instance_destroy(interactable.id)
				holding = noone
			}
		} else if interactable.object_index == Crab and holding == Crab {
			instance_create_layer(interactable.x, interactable.bbox_top - interactable.sprite_height, "Instances", Crab)
			holding = noone
		}
	}	
}

function on_dropped() {
	if !holding {
		show_error("on_dropped called when nothing is being held", false)
		return	
	}

}

function get_player_position() {
	return [Player.x, Player.y + 7]
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
		
		if holding {
			on_dropped()
		}
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