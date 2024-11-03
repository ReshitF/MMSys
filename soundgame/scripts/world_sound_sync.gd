extends Node2D

@onready var sound_source_2d = $"Enemy"  # Reference to your 2D sound source
@onready var audio_player_3d = $"sound_node/step_1"  # Reference to the 3D audio player
@onready var listener_3d = $"sound_node/camera"  # Reference to the 3D listener (optional)
@onready var player_2d = $Player
# Fixed z-position for 3D audio, since we're only working with x and y from 2D
const FIXED_Z_POSITION = 0.0  
	

func _process(delta: float) -> void:
	# Update the 3D audio position based on the 2D position of the sound source
	var pos_2d = sound_source_2d.global_position
	audio_player_3d.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	print("AudioPlayer3D Position:", audio_player_3d.position)
	# Optional: Update the 3D listener to follow the 2D camera or player position
	var camera_2d = get_viewport().get_camera_2d()  # Assuming there's a 2D camera in your project
	var player_pos_2d = player_2d.global_position
	listener_3d.position = Vector3(player_pos_2d.x, player_pos_2d.y, FIXED_Z_POSITION)
	print("Listener3D Position:", listener_3d.position)
	print("Distance ", listener_3d.position.distance_to(audio_player_3d.position))
	
