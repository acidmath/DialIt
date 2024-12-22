extends AudioStreamPlayer2D
@onready var audio_stream_player_2d = $"."

func _ready():
	audio_stream_player_2d.connect("finished", Callable(self, "_on_loop_sound").bind(audio_stream_player_2d))
	
func _on_loop_sound(player):
	player.stream_paused = false
	player.play()
