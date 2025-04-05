extends Node

var _audio_stream_players: Array[AudioStreamPlayer] = []
var _max_players: int = 0
var _current_index: int = 0

func _ready() -> void:
	for a in get_children():
		if a is AudioStreamPlayer:
			_audio_stream_players.append(a)
	_max_players = _audio_stream_players.size()


func play_sound(stream: AudioStream, volume: float = -5) -> void:
	var current_player := _audio_stream_players[_current_index]
	_current_index = (_current_index + 1) % _max_players
	current_player.volume_db = volume
	current_player.stop()
	current_player.stream = stream
	current_player.play()
	
