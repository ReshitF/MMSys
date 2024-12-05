extends Area2D
@onready var navigation_agent:NavigationAgent2D = $"../NavigationAgent2D"
@onready var enemy:CharacterBody2D = $".."
@onready var player:CharacterBody2D = $"../../Player"
#@onready var 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name == "NoiseRange" and (area.collision_layer & (1 << 0)):
		print("ENEMY AudioRange has detected PLAYER NoiseRange")
		var player_velocity_meter = player.velocity.length()
		if player_velocity_meter>0:
			print("player moving --> CHASING MODE")
			enemy.chase=true
		else:
			print("player not moving --> not chasing")
func _on_area_exited(area: Area2D) -> void:
	if area.name == "NoiseRange" and (area.collision_layer & (1 << 0)):
		var player_velocity_meter = player.velocity.length()
		if player_velocity_meter>0:
			print("player moving --> CHASING MODE")
			enemy.chase=true
		else:
			print("player not moving --> not chasing")
#func _on_area_exited(area:Area2D) -> void:
	#if area.name == "NoiseRange" and (area.collision_layer & (1 << 0)):
		#print("player exits")
