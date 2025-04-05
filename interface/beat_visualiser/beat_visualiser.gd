extends Control
class_name BeatVisualizer

@onready var _diamond_visual: DiamondVisual = $DiamondVisual

@onready var _label_quality: Label = %LabelQuality
@onready var _timer_hide_quality: Timer = %TimerHideQuality

## beat quality stuff
var _late_available: bool = false ## set to true after the first beat
static var current_beat_quality: PT.BeatQuality

func _ready() -> void:
	EventBus.beat_update.connect(_on_beat_update)
	EventBus.combo_or_skill_pressed.connect(_combo_or_skill_pressed)
	EventBus.visualiser_beat_passed.connect(_combo_or_skill_pressed)
	_timer_hide_quality.timeout.connect(_on_timer_hide_quality_timeout)
	_label_quality.hide()
	
	_reset_beat_quality()


func _process(_delta: float) -> void:
	var difference: float = _diamond_visual.get_remaining_distance()
	## PERFECT
	if -5 <= difference and difference <= 15:
		current_beat_quality = PT.BeatQuality.PERFECT
	elif 15 < difference and difference <= 35:
		current_beat_quality = PT.BeatQuality.EARLY
	elif (-12 <= difference and difference < -5) and _late_available:
		current_beat_quality = PT.BeatQuality.LATE
	elif (35 < difference and difference <= 70) or difference < -12:
		current_beat_quality = PT.BeatQuality.MISS
	else:
		current_beat_quality = PT.BeatQuality.NONE
	#print(percent)


func _reset_beat_quality() -> void:
	current_beat_quality = PT.BeatQuality.NONE
	_late_available = false


func _get_beat_quality_string(beat_quality: PT.BeatQuality) -> String:
	match beat_quality:
		PT.BeatQuality.PERFECT:
			return "PERFECT"
		PT.BeatQuality.EARLY:
			return "EARLY"
		PT.BeatQuality.LATE:
			return "LATE"
		PT.BeatQuality.MISS:
			return "MISS"
		_:
			return "Pass"


func _get_beat_quality_color(beat_quality: PT.BeatQuality) -> Color:
	match beat_quality:
		PT.BeatQuality.PERFECT:
			return Color.GOLD
		PT.BeatQuality.EARLY:
			return Color.LIGHT_SEA_GREEN
		PT.BeatQuality.LATE:
			return Color.LIGHT_SEA_GREEN
		PT.BeatQuality.MISS:
			return Color.RED
		_:
			return Color.GRAY



func _on_beat_update() -> void:
	_diamond_visual.update_beat_animation()
	_late_available = true


func _combo_or_skill_pressed(beat_quality: PT.BeatQuality) -> void:
	_label_quality.show()
	_label_quality.text = _get_beat_quality_string(beat_quality)
	_label_quality.modulate = _get_beat_quality_color(beat_quality)
	_timer_hide_quality.start()
	#if _main_tween:
		#_main_tween.stop()
	#_main_tween = create_tween()


func _on_timer_hide_quality_timeout() -> void:
	_label_quality.hide()
