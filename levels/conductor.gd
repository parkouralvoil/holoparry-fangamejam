extends AudioStreamPlayer
class_name Conductor

## static lets anyone retrieve the the variable from the class
## and makes the variable shared among different Conductor instances 
## (tho theres only one Conductor instance so the 2nd point is not necessary)
static var bpm := 150
static var measures := 4

##Beat and Song position
static var sec_per_beat: float = 60.0 / bpm
var song_position: float = 0.0
var song_position_in_beats: int = 0
var last_reported_beat: int = 0
var beat_before_start: int = 0
var current_measure: int = 0

#Variables for Action in sync with beat
#var closest: int = 0
#var time_off_beat: float = 0.0

@onready var _Metronome: AudioStreamPlayer = $Metronome

func _ready() -> void:
	play_from_beat(0, 0)

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
		EventBus.beat_update.emit()
		EventBus.measure_update.emit(current_measure)
		last_reported_beat = song_position_in_beats
		current_measure += 1
		
		_Metronome.play()

func play_from_beat(starting_beat: int, offset_beat: int):
	play()
	seek(starting_beat * sec_per_beat)
	beat_before_start = offset_beat
	
