extends CharacterBody2D

const SPEED = 300.0

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
