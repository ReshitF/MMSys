extends AudioStreamPlayer2D

var last_pitch = 1.0
func randomize_and_play(from_position: float = 0.0) -> void:
	randomize()
	pitch_scale = randf_range(0.95, 1.05)
	
	while abs(pitch_scale-last_pitch) <.01:
		randomize()
		pitch_scale = randf_range(0.95, 1.05)
	last_pitch = pitch_scale
	await _pause(.05)
	play(from_position)

@onready var timer = $"../Timer"
func _pause(dt: float = 0.1) -> void:
	timer.wait_time = dt  # Set the timer for 0.1 seconds
	timer.start()          # Start the timer
	await timer.timeout    # Wait for the timer to finish
