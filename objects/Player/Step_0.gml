var y_offset = 20

if !Claw.extending and horizontal_speed == 0 and vertical_speed == 0{
	if keyboard_check(vk_space) {
		Claw.extending = 1
		Claw.image_speed = 0.7
		Claw.image_index = 1
	}
}

var acceleration = 2
var _dt = delta_time / 1000000;

var maxHSpeed = 4
var maxVSpeed = 2.2
var maxTotalSpeed = 7
var customFriction = 1.3

var moving = false
var newhspeed = 0
var newvspeed = 0 
if !Claw.extending {
	if keyboard_check(vk_left) or keyboard_check(ord("A")) {
		moving = true
		horizontal_speed = clamp(horizontal_speed - acceleration * _dt, -maxHSpeed, maxHSpeed)
		image_xscale = -1
		Claw.image_xscale = -1
		
	} else if keyboard_check(vk_right) or keyboard_check(ord("D")) {
		moving = true
		horizontal_speed = clamp(horizontal_speed + acceleration * _dt, -maxHSpeed, maxHSpeed)
		image_xscale = 1
		Claw.image_xscale = 1
	}

	if keyboard_check(vk_up) or keyboard_check(ord("W")) {
		moving = true
		vertical_speed = clamp(vertical_speed - acceleration * _dt, -maxVSpeed, maxVSpeed)
	} else if keyboard_check(vk_down) or keyboard_check(ord("S")) {
		moving = true
		vertical_speed = clamp(vertical_speed + acceleration * _dt, -maxVSpeed, maxVSpeed)
	}
}


// Apply slowdown friction only when not moving
if !moving {
	if horizontal_speed > 0 {
		horizontal_speed = horizontal_speed - customFriction * _dt
	
		if horizontal_speed < 0 {
			horizontal_speed = 0	
		}
	} else if horizontal_speed < 0 {
		horizontal_speed = horizontal_speed + customFriction * _dt
	
		if horizontal_speed > 0 {
			horizontal_speed = 0
		}
	}

	if vertical_speed > 0 {
		vertical_speed = vertical_speed - customFriction * _dt
	
		if vertical_speed < 0 {
			vertical_speed = 0	
		}
	} else if vertical_speed < 0 {
		vertical_speed = vertical_speed + customFriction * _dt
	
		if vertical_speed > 0 {
			vertical_speed = 0	
		}
	}
}


if array_length(move_and_collide(horizontal_speed, vertical_speed, Solid, 20)) != 0 {
	vertical_speed = 0
	horizontal_speed = 0
	sprite_index = player_blushing
	alarm_set(0, 1.5 * game_get_speed(gamespeed_fps))
}
