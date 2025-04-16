global.solved_tasks = 0
global.collected_crystals = 0


function task_solved(){
	var TASKS_TO_WIN = 5
	global.solved_tasks += 1
	if(global.solved_tasks >= TASKS_TO_WIN) {
		room_goto(VictoryRoom)
	}
}

function crystal_collected() {
	var CRYSTALS_TO_WIN = 5

	global.collected_crystals += 1
	if(global.collected_crystals >= CRYSTALS_TO_WIN) {
		room_goto(DefeatRoom)
	} else {
		earthquake = layer_get_id("Earthquake")
		fx = layer_get_fx(earthquake)
		var crystals_multiplier = power(global.collected_crystals, 1.25)
		fx_set_parameter(fx, "g_Magnitude", 1 * crystals_multiplier)
		fx_set_parameter(fx, "g_ShakeSpeed", 0.9 * crystals_multiplier)
		alarm_set(0, 1 * game_get_speed(gamespeed_fps))

		for(i = 0; i < random_range(3 * crystals_multiplier, 7 * crystals_multiplier); i++) {
			yPosition = Player.y - camera_get_view_height(1)/2 - 20 + random(5)
			xPosition = Player.x - random_range(-camera_get_view_width(1)/2 - 5, camera_get_view_width(1)/2 - 5)
			instance_create_layer(xPosition, yPosition, "Instances", FallingRock)
		}	
	}
}