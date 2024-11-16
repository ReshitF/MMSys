extends PathFollow2D
@onready var enemy = $"Enemy"

@export var speed = 10
func _process(delta: float) -> void:
	self.progress += speed*delta
