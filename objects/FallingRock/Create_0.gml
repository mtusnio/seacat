image_angle = random(360)

var scale = random_range(0.3, 1.3)
image_xscale = scale
image_yscale = scale
gravity = random_range(0.05, 0.15)
gravity_direction = 270

alarm_set(0, 4 * game_get_speed(gamespeed_fps))