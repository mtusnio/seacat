enum ExtendingState {
	None = 0,
	Extending = 1,
	Retracting = 2,
	Stuck = 3,
}

function resolve_claw_holding_animation() {
	if holding.object_index == Crab {
		sprite_index = claw_crab
	} else if holding.object_index == OilRock {
		sprite_index = claw_rock
	}
}

function scratch() {
	
}
/// @func on_collided(interactable)
/// @param {Id.Instance} interactable
function on_collided(interactable) {
	extending = ExtendingState.Retracting

	if !holding {
		if interactable.object_index == Crystal {
			crystal_collected()

			instance_destroy(interactable.id)
		} else if interactable.object_index == WhaleItchy {
			if !WhaleItchy.Scratched {
				task_solved()
				WhaleItchy.Scratched = true
				interactable.sprite_index = whale
				extending = ExtendingState.Stuck
				alarm_set(2, 0.2 * game_get_speed(gamespeed_fps))
			}
		} else {
			if variable_instance_exists(interactable.id, "Pickable") and variable_instance_get(interactable.id, "Pickable") {
				holding = interactable.object_index
				resolve_claw_holding_animation()
				instance_destroy(interactable.id)	
			}
		}
	} else {
		if interactable.object_index == OilSeep {
			if holding == OilRock {
				task_solved()
				var created = instance_create_layer(interactable.x, interactable.y, "Instances", OilRock)
				variable_instance_set(created, "Pickable", false)
				instance_destroy(interactable.id)
				holding = noone
			}
		} else if interactable.object_index == Crab and holding == Crab {
			show_debug_message("Bbox_top: {0} Sprite height: {1}", interactable.bbox_top, interactable.sprite_height)
			var drop_y_pos = crab_head_y(interactable)
			show_debug_message("Drop Y Pos: {0}", drop_y_pos)
			var created_crab = instance_create_layer(interactable.x, drop_y_pos, "Instances", Crab)
			var current_stack_size = variable_instance_get(interactable.id, "StackSize")
			variable_instance_set(created_crab.id, "StackSize", current_stack_size + 1)
			holding = noone
		}
	}	
}

function on_dropped() {
	if !holding {
		show_error("on_dropped called when nothing is being held", false)
		return	
	}
	
	var y_pos = y + 1
	var x_pos = x - 8
	if holding == OilRock {
		y_pos = y - 8
	} else {
		x_pos = x - holding.sprite_width / 2
	}

	instance_create_layer(x_pos, y_pos, "Instances", holding)
	holding = noone
	image_index = claw_open
}

function get_player_position() {
	return [Player.x, Player.y + 7]
}

function get_player_orientation() {
	return Player.image_xscale
}

function claw_extend() {
	var interactable_collided = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, Interactable, false, true)
	
	if interactable_collided {
		on_collided(interactable_collided)
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
		if !holding {
			sprite_index = claw_open
		}
		alarm_set(1, claw_retract_speed * game_get_speed(gamespeed_fps)) 
	} else if  extending == ExtendingState.Extending {
		if !holding {
			sprite_index = claw_open
		}
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
		
		if !holding {
			sprite_index = claw
		}
	}
}