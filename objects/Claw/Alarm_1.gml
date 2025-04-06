
if extending == ExtendingState.Extending {
	claw_extend()
} else if extending == ExtendingState.Retracting {
	claw_retract()
}