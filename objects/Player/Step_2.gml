var y_offset = 20

if !Claw.extending and speed == 0 {
	if keyboard_check(vk_space) {
		extend_claw()
	}
}

var acceleration = 2
var _dt = delta_time / 1000000;

var maxHSpeed = 4
var maxVSpeed = 2.2
var maxTotalSpeed = 7
var customFriction = 1.3

var moving = false
if !Claw.extending {
	if keyboard_check(vk_left) {
		moving = true
		hspeed = clamp(hspeed - acceleration * _dt, -maxHSpeed, maxHSpeed)
	} else if keyboard_check(vk_right) {
		moving = true
		hspeed = clamp(hspeed + acceleration * _dt, -maxHSpeed, maxHSpeed)
	}

	if keyboard_check(vk_up) {
		moving = true
		vspeed = clamp(vspeed - acceleration * _dt, -maxVSpeed, maxVSpeed)
	} else if keyboard_check(vk_down) {
		moving = true
		vspeed = clamp(vspeed + acceleration * _dt, -maxVSpeed, maxVSpeed)
	}
	
	speed = clamp(speed, -maxTotalSpeed, maxTotalSpeed)
}


if !moving {
	if hspeed > 0 {
		hspeed = hspeed - customFriction * _dt
	
		if hspeed < 0 {
			hspeed = 0	
		}
	} else if hspeed < 0 {
		hspeed = hspeed + customFriction * _dt
	
		if hspeed > 0 {
			hspeed = 0
		}
	}

	if vspeed > 0 {
		vspeed = vspeed - customFriction * _dt
	
		if vspeed < 0 {
			vspeed = 0	
		}
	} else if vspeed < 0 {
		vspeed = vspeed + customFriction * _dt
	
		if vspeed > 0 {
			vspeed = 0	
		}
	}
}

// x = clamp(x, sprite_width, room_width - sprite_width)
// y = clamp(y, sprite_height, room_height - sprite_height - y_offset)

move_bounce_solid(true)
