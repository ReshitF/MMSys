extends CharacterBody2D

const SPEED = 300.0
const VOLUME_INCREASE_RATE = 0.1  # Adjust this for the speed of volume increase

@onready var listener_3d = $"microphone"  # Reference to the 3D listener (optional)
@onready var audio_player = $footsteps # Reference to the AudioStreamPlayer2D
const FIXED_Z_POSITION = 0.0  

@export var inventory: Inv
@export var hasKey: bool = false

var playback_pos: float = 0.0
var last_direction = "down"  # Default direction for idle animations

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
		last_direction = "up"
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("press_s"):
		direction.y += 1
		last_direction = "down"
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("press_a"):
		direction.x -= 1
		last_direction = "left"
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("press_d"):
		direction.x += 1
		last_direction = "right"

	# Normalize direction to prevent faster diagonal movement
	if direction != Vector2.ZERO:
		if hasKey:
			if !$keySound.is_playing():
				$keySound.play(playback_pos)
		direction = direction.normalized() * SPEED

		 #Play the appropriate movement animation
		match last_direction:
			"up":
				$AnimatedSprite2D.play("up")
			"down":
				$AnimatedSprite2D.play("down")
			"left":
				$AnimatedSprite2D.play("left")
			"right":
				$AnimatedSprite2D.play("right")
	else:
		# Play idle animation when not moving
		if hasKey and $keySound.is_playing():
			playback_pos = $keySound.get_playback_position()
			$keySound.stop()
		match last_direction:
			"up":
				$AnimatedSprite2D.play("idle_up")
			"down", "left", "right":  # Default idle for left/right is "idle_down"
				$AnimatedSprite2D.play("idle_down")

	# Set velocity and move
	velocity = direction
	move_and_slide()
	var mouse_position = get_global_mouse_position()
	$PointLight2D.look_at(mouse_position)

func collect(item):
	inventory.insert(item)
	
func player():
	pass
