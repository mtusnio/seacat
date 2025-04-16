global.solved_tasks = 0
global.collected_crystals = 0

var CRYSTALS_TO_WIN = 5
var TASKS_TO_WIN = 5

function task_solved(){
	global.solved_tasks += 1
	if(global.solved_tasks >= TASKS_TO_WIN) {
		
	}
}

function crystal_collected() {
	global.collected_crystals += 1
	if(global.collected_crystals >= CRYSTALS_TO_WIN) {
		
	}
}