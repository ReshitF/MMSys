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
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://finish.tscn")
	elif open:
		sprite.play("close")
		open = false
		collision.disabled = false
