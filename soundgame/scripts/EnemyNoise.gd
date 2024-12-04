extends Node
# Reference to the two audio players
@onready var audio_player1 = $"step_1"
@onready var audio_player2 = $"step_2"
@onready var dt = 0.5
func _ready():
	# Connect each player's "finished" signal to a function
	audio_player1.finished.connect(_on_audio_player1_finished)
	audio_player2.finished.connect(_on_audio_player2_finished)

func set_noise_distance(player_range):
	var col_shape = $CollisionShape2D.shape
	var radius = 80
	if col_shape is CircleShape2D:
		radius = col_shape.radius
	audio_player1.max_distance = player_range + radius
	audio_player2.max_distance = player_range + radius
	print('set max distance to',player_range + radius)
	
func set_interval(interval=0.5):
	dt = interval

func start_noise():
	# Start the first player
	audio_player1.play()

func stop_noise():
	# Start the first player
	#audio_player1.stop()
	#audio_player2.stop()
	pass
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_audio_player1_finished():
	# When the first audio finishes, start the second
	await wait(dt)
	audio_player2.play()


func _on_audio_player2_finished():
	# When the second audio finishes, loop back to the first
	await wait(dt)
	audio_player1.play()
