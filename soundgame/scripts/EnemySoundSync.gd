extends CharacterBody2D

@onready var audio_player_3d = $"NoiseRange/step_1"  # Reference to the 3D audio player
@onready var audio_player_3d_2 = $"NoiseRange/step_2"  # Reference to the 3D audio player
@export var target_to_chase: CharacterBody2D = null
@onready var navigation_agent :NavigationAgent2D =$NavigationAgent2D
@onready var chase :bool = false

const FIXED_Z_POSITION = 0.0  
const SPEED = 100
func _process(delta: float) -> void:
	var pos_2d = self.global_position
	audio_player_3d.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	audio_player_3d_2.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	#print("AudioPlayer3D Position:", audio_player_3d.position)
	if target_to_chase != null:
		navigation_agent.target_position = target_to_chase.global_position			
	#if navigation_agent.tdddarget_position != null:
	if self.chase:
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
		var target = navigation_agent.target_position
		var dist = global_position.distance_to(target)
		if dist>500:
			self.chase=false
			velocity= velocity*0
	if !navigation_agent.is_target_reached():
		move_and_slide()
