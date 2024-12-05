extends Node
@export var background_music: AudioStream
@export var chase_music: AudioStream
@onready var audio_player = AudioStreamPlayer.new()
@onready var fade_duration: float = 1.0

func _ready():
	add_child(audio_player)
	background_music = preload("res://assets/ambient_music.mp3")
	chase_music = preload("res://assets/chase_music.mp3")
	play_background_music() # start with background
	#play_chase_music()

func play_background_music():
	if audio_player.stream != background_music:
		audio_player.stop()
		audio_player.stream = background_music
		audio_player.volume_db = -24
		audio_player.play()
func play_chase_music():
	if audio_player.stream != chase_music:
		audio_player.stop()  # Stop the current track before switching
		audio_player.stream = chase_music
		audio_player.volume_db = -12
		audio_player.play()
		audio_player.seek(1)
func stop_music():
	if audio_player.playing:
		audio_player.stop()
