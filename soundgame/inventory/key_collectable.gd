extends StaticBody2D

@export var item: InvItem
var player = null

func _on_interactable_area_body_entered(body):
	if body.has_method("player"):
		player = body
		playercollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()
		player.hasKey = true
		player.get_node("NoiseRange").get_child(0).get_shape().radius = 100.0
		
func playercollect():
	player.collect(item)
