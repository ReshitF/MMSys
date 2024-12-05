extends CharacterBody2D

@onready var audio_player_3d = $"NoiseRange/step_1"  # Reference to the 3D audio player
@onready var audio_player_3d_2 = $"NoiseRange/step_2"  # Reference to the 3D audio player
@export var target_to_chase: CharacterBody2D = null
@onready var target_move: Node2D = null
@onready var navigation_agent :NavigationAgent2D =$NavigationAgent2D
@onready var chase :bool = false
@onready var pos1=$"../pos1"
@onready var pos2=$"../pos2"
@onready var pos3=$"../pos3"
@onready var noise_range=$NoiseRange

const FIXED_Z_POSITION = 0.0  

var SPEED_DEFAULT = 50
var SPEED_CHASE = 100
var SPEED = SPEED_DEFAULT
@export var chase_theme: AudioStream  # The chase music to play

func start_chasing():
	if self.chase:
		self.chase = true
		print("Chase started!")
		music.play_chase_music()

func stop_chasing():
	if self.chase:
		self.chase = false
		print("Chase stopped!")
		music.play_background_music()

func _process(delta: float) -> void:
	var pos_2d = self.global_position
	audio_player_3d.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	audio_player_3d_2.position = Vector3(pos_2d.x, pos_2d.y, FIXED_Z_POSITION)
	#print("AudioPlayer3D Position:", audio_player_3d.position)
	if target_to_chase != null:
		navigation_agent.target_position = target_to_chase.global_position			
	#if navigation_agent.tdddarget_position != null:
	if !self.chase: # PATROL MODE
		noise_range.set_interval(0.5)
		if target_move == null:
			randomize()
			var options = [pos1,pos2,pos3]
			var rand_idx:int = randi()%options.size()
			target_move = options[rand_idx]
			#print("PATROLING")
			#print("going towards",target_move)
		var pos = target_move.global_position
		var pos_enemy = self.global_position
		navigation_agent.target_position = pos
		
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
		if navigation_agent.is_target_reached():
			target_move=null
	
	if self.chase: # CHASE MODE
		noise_range.set_interval(0)
		SPEED=SPEED_CHASE
		music.play_chase_music()
		navigation_agent.target_position = target_to_chase.global_position
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
		var target = navigation_agent.target_position
		var dist = global_position.distance_to(target)
		if dist>500:
			stop_chasing()
			SPEED=SPEED_DEFAULT
			velocity= velocity*0
		if dist<42:
			print("Game Over")
			stop_chasing()
			get_tree().change_scene_to_file("res://startmenu.tscn")
	
			
			
	if !navigation_agent.is_target_reached():
		move_and_slide()
