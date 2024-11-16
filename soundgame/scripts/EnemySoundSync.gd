extends CharacterBody2D

@onready var audio_player_3d = $"NoiseRange/step_1"  # Reference to the 3D audio player
@onready var audio_player_3d_2 = $"NoiseRange/step_2"  # Reference to the 3D audio player

const FIXED_Z_POSITION = 0.0  

func _process(delta: float) -> void:
	var pos_2d = self.global_position
	audio_player_3d.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	audio_player_3d_2.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	#print("AudioPlayer3D Position:", audio_player_3d.position)
