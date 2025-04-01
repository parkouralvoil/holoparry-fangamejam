extends Control
class_name BeatVisualizer

@onready var _main_hitMarker: TextureRect = $main_visual/Main
@onready var _main_animationPlayer: AnimationPlayer = %MainAnimation
@onready var _left_animationPlayer: AnimationPlayer = %LeftAnimation
@onready var _right_animationPlayer: AnimationPlayer = %RightAnimation

@onready var _label_quality: Label = %LabelQuality
@onready var _timer_hide_quality: Timer = %TimerHideQuality

var scale_hitmarker = (0.1 / Conductor.sec_per_beat) + 0.05

## beat quality stuff
var _late_available: bool = false ## set to true after the first beat
static var current_beat_quality: PT.BeatQuality
## percentages
var _perfect_threshold: float = 0.95
var _early_threshold: float = 0.75
var _late_threshold: float = 0.15

func _ready() -> void:
	_left_animationPlayer.speed_scale = scale_hitmarker
	_right_animationPlayer.speed_scale = scale_hitmarker
	EventBus.beat_update.connect(_on_beat_update)
	EventBus.combo_or_skill_pressed.connect(_combo_or_skill_pressed)
	_timer_hide_quality.timeout.connect(_on_timer_hide_quality_timeout)
	_label_quality.hide()
	
	_reset_beat_quality()


func _process(_delta: float) -> void:
	if not _right_animationPlayer.is_playing():
		#print("not playing")
		if _late_available:
			current_beat_quality = PT.BeatQuality.PERFECT
		else:
			current_beat_quality = PT.BeatQuality.MISS
		return
	var current_time: float = _right_animationPlayer.current_animation_position
	var length: float = _right_animationPlayer.current_animation_length
	var percent: float = current_time/length
	## PERFECT
	if percent >= _perfect_threshold:
		current_beat_quality = PT.BeatQuality.PERFECT
	elif percent >= _early_threshold:
		current_beat_quality = PT.BeatQuality.EARLY
	elif percent <= _late_threshold and _late_available:
		current_beat_quality = PT.BeatQuality.LATE
	else:
		current_beat_quality = PT.BeatQuality.MISS
	#print(percent)


func _reset_beat_quality() -> void:
	current_beat_quality = PT.BeatQuality.MISS
	_late_available = false


func _get_beat_quality_string(beat_quality: PT.BeatQuality) -> String:
	match beat_quality:
		PT.BeatQuality.PERFECT:
			return "PERFECT"
		PT.BeatQuality.EARLY:
			return "EARLY"
		PT.BeatQuality.LATE:
			return "LATE"
		_:
			return "MISS"


func _get_beat_quality_color(beat_quality: PT.BeatQuality) -> Color:
	match beat_quality:
		PT.BeatQuality.PERFECT:
			return Color.GOLD
		PT.BeatQuality.EARLY:
			return Color.LIGHT_SEA_GREEN
		PT.BeatQuality.LATE:
			return Color.LIGHT_SEA_GREEN
		_:
			return Color.RED



func _on_beat_update() -> void:
	_main_animationPlayer.play("pulsating")
	_left_animationPlayer.play("left_hitmarker_to_main")
	_right_animationPlayer.play("right_hitmarker_to_main")
	_late_available = true


func _combo_or_skill_pressed(beat_quality: PT.BeatQuality) -> void:
	_label_quality.show()
	_label_quality.text = _get_beat_quality_string(beat_quality)
	_label_quality.modulate = _get_beat_quality_color(beat_quality)
	_timer_hide_quality.start()


func _on_timer_hide_quality_timeout() -> void:
	_label_quality.hide()
