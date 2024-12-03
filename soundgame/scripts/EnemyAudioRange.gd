extends Area2D
@onready var navigation_agent:NavigationAgent2D = $"../NavigationAgent2D"
@onready var enemy:CharacterBody2D = $".."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name == "NoiseRange" and (area.collision_layer & (1 << 0)):
		print("ENEMY AudioRange has detected PLAYER NoiseRange")
		#navigation_agent.target_position = area.global_position
		enemy.chase=true
		
		
	pass # Replace with function body.
