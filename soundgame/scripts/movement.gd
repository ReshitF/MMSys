extends CharacterBody2D

const SPEED = 300.0
const VOLUME_INCREASE_RATE = 0.1  # Adjust this for the speed of volume increase

# Reference to the AudioStreamPlayer2D
@onready var audio_player = $AudioStreamPlayer2D

func _ready() -> void:
	pass
	# Start playing the sound

func _process(delta: float) -> void:
	# Increase the volume slowly over time
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
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	# Normalize direction to prevent faster diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized() * SPEED

	# Set velocity and move
	velocity = direction
	move_and_slide()

	# Make the sprite face the mouse
	var mouse_position = get_global_mouse_position()
	$Sprite2D.look_at(mouse_position)
