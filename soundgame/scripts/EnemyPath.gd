extends PathFollow2D

@export var speed = 100
func _process(delta: float) -> void:
	self.progress += speed*delta
	#print(path_follow.progress)
	#pass
