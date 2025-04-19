if global.collected_crystals >= global.crystals_to_win {
	room_goto(DefeatRoom)	
} else if global.tasks_to_win >= global.tasks_to_win {
	room_goto(VictoryRoom)	
}