extends CharacterBody2D

const SPEED = 300.0
const VOLUME_INCREASE_RATE = 0.1  # Adjust this for the speed of volume increase

@onready var listener_3d = $"microphone"  # Reference to the 3D listener (optional)
@onready var audio_player = $footsteps # Reference to the AudioStreamPlayer2D
const FIXED_Z_POSITION = 0.0  

func _ready() -> void:
	pass
	
	# Start playing the sound

func _process(delta: float) -> void:
	# Increase the volume slowly over time
	var player_pos_2d = self.global_position
	
	listener_3d.position = Vector3(player_pos_2d.x, player_pos_2d.y, FIXED_Z_POSITION)
	#print("Listener3D Position:", listener_3d.position)
	audio_player.volume_db = clamp(audio_player.volume_db + VOLUME_INCREASE_RATE * delta, -80, 0)
	
	# Check for pause/resume input
	if Input.is_action_just_pressed("ui_accept"):  # Default "ui_accept" is spacebar
		if audio_player.playing:
			audio_player.stop()
		else:
			audio_player.play()

func _physics_process(delta: float) -> void:
	# Initialize direction vector
	var direction = Vector2.ZERO

	# Get input for movement on both x and y axes

	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("press_w"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("press_s"):
		direction.y += 1
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("press_a"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("press_d"):
		direction.x += 1

	# Normalize direction to prevent faster diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized() * SPEED

	# Set velocity and move
	velocity = direction
	move_and_slide()

	# Make the sprite face the mouse
	var mouse_position = get_global_mouse_position()
	self.look_at(mouse_position)
