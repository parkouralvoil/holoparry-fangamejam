extends Node2D
class_name BeatsManager

var _on_beat: bool = false:
	set(val):
		_on_beat = val
		EventBus.beat_window_changed.emit(val)
# dependent on song choice, will need smth to handle these
var _beat_timing_duration: float = 60.0 / 150.0
var _onbeat_window_duration: float = (60.0 / 150.0) * 0.9

@onready var _BeatTiming: Timer = $BeatTiming
@onready var _OnBeatWindow: Timer = $OnBeatWindow
@onready var _TestMetronome: AudioStreamPlayer = $TestMetronome

func _ready() -> void:
	## play test song
	$Conductor.play_from_beat(4,0)
	_TestMetronome.play()
	_BeatTiming.start(_beat_timing_duration)
	_BeatTiming.timeout.connect(_on_BeatTiming_timeout)
	_OnBeatWindow.timeout.connect(_on_OnBeatWindow_timeout)

func _on_BeatTiming_timeout() -> void:
	## start the on-beat window
	_OnBeatWindow.start(_onbeat_window_duration)
	_TestMetronome.play()
	_on_beat = true

func _on_OnBeatWindow_timeout() -> void:
	## end the on-beat window
	_on_beat = false
