var earthquake = layer_get_id("Earthquake")
var fx = layer_get_fx(earthquake)

var magnitude = max(fx_get_parameter(fx, "g_Magnitude") - 1, 0)
fx_set_parameter(fx, "g_Magnitude", magnitude)

if magnitude == 0 {
	fx_set_parameter(fx, "g_ShakeSpeed", 0)
} else {
	alarm_set(0, 1 * game_get_speed(gamespeed_fps))
}

layer_set_fx(earthquake, fx)