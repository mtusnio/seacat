
if !Pressed {
	Pressed = true
	sprite_index = button_pressed
	instance_destroy(Door)

	if NotifyObject != undefined {
		with(NotifyObject) {
			event_user(0)
		}
	}
}