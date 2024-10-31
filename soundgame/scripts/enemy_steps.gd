extends Node
# Reference to the two audio players
@onready var audio_player1 = $"step_1"
@onready var audio_player2 = $"step_2"

func _ready():
	# Connect each player's "finished" signal to a function
	audio_player1.finished.connect(_on_audio_player1_finished)
	audio_player2.finished.connect(_on_audio_player2_finished)
	
	# Start the first player
	audio_player1.play()

func _on_audio_player1_finished():
	# When the first audio finishes, start the second
	audio_player2.play()

func _on_audio_player2_finished():
	# When the second audio finishes, loop back to the first
	audio_player1.play()
