extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	# Check if the detected area is the enemy's NoiseRange
	if area.name == "NoiseRange" and (area.collision_layer & (1 << 1)):
		var enemy = area.get_parent()
		print("PLAYER AudioRange has detected ENEMY NoiseRange")
		var player_range=80
		var shape = $CollisionShape2D.shape
		if shape is CircleShape2D:
			player_range = shape.radius
		area.set_noise_distance(player_range)
		area.start_noise()
		
		#if not audio_player.playing:
			#audio_player.play()  # Start playing the footsteps soundtion body.


func _on_area_exited(area: Area2D) -> void:
	# Stop the footsteps sound when the enemy leaves the range
	if area.name == "NoiseRange" and (area.collision_layer & (1 << 1)):
		print("PLAYER AudioRange has lost ENEMY NoiseRange")
		area.stop_noise()
		#if audio_player.playing:
			#audio_player.stop()  # Stop playing the footsteps sound
