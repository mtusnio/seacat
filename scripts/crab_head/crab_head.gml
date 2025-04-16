function crab_head_y(passed_crab){
	show_debug_message("Bbox_top: {0} Sprite height: {1}", passed_crab.bbox_top, passed_crab.sprite_height)
	return passed_crab.bbox_top - passed_crab.sprite_height
}