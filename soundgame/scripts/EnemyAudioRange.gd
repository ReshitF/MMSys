extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name == "NoiseRange" and (area.collision_layer & (1 << 0)):
		print("ENEMY AudioRange has detected PLAYER NoiseRange")
	pass # Replace with function body.
