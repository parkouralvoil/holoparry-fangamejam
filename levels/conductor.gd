extends AudioStreamPlayer
class_name Conductor

@export var bpm := 150
@export var measures := 4

#Beat and Song position
var song_position: float = 0.0
var song_position_in_beats: int = 0
var sec_per_beat: float = 60.0 / bpm
var last_reported_beat: int = 0
var beat_before_start: int = 0
var current_measure: int = 0

#Variables for Action in sync with beat
var closest: int = 0
var time_off_beat: float = 0.0

signal beat(position: int)
signal measure(position: int)

@onready var _TestMetronome: AudioStreamPlayer = $Metronome

func _ready():
	pass

func _process(delta: float) -> void:
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beat_before_start
		_report_beat()
		
func _report_beat():
	if last_reported_beat < song_position_in_beats:
		if current_measure >= measures:
			current_measure = 0
		beat.emit(song_position_in_beats)
		measure.emit(current_measure)
		last_reported_beat = song_position_in_beats
		current_measure += 1
		
		#print_debug("Beat ", song_position_in_beats, ", Measure ", str(current_measure))
		_TestMetronome.play()

func play_from_beat(beat: int, offset_beat: int):
	play()
	seek(beat * sec_per_beat)
	beat_before_start = offset_beat
	
