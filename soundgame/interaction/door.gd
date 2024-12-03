extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var player = $"../Player"

var open: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open = false
	interaction_area.interact = Callable(self, "_interact_door")


func _interact_door():
	if !open && player.hasKey:
		sprite.play("open")
		open = true
		collision.disabled = true
	elif open:
		sprite.play("close")
		open = false
		collision.disabled = false
