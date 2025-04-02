extends TextureRect
class_name DiamondLine

signal reached_final_pos()

@export var _is_left_line: bool = true
var _final_x: float
var _dist: float
var _late_offset: float = 12

var _speed: float
var _time: float = 1

var _moving: bool = false
var current_line: bool = false
var _pressed: bool = false

var _default_color := Color.DEEP_SKY_BLUE
var _miss_color := Color.DIM_GRAY
var _current_color := Color.DEEP_PINK
var _pressed_color := Color.GOLD

func _ready() -> void:
	if _is_left_line:
		_final_x = 6 ## [-6, 6]
		_dist = -100
	else:
		_final_x = 33 ## [33, 45]
		_dist = 100

func _physics_process(delta: float) -> void:
	if not _moving:
		return
	_speed = (_dist/_time) * delta
	if current_line:
		modulate = _current_color
	else:
		modulate = _default_color
	if _is_left_line:
		position.x = min(position.x - _speed, _final_x + _late_offset)
		## offset is to ensure its ready during the next beat
		if position.x >= _final_x + _late_offset:
			_miss_reset_line()
	else:
		position.x = max(position.x - _speed, _final_x - _late_offset)
		if position.x <= _final_x - _late_offset:
			_miss_reset_line()
			


func _miss_reset_line() -> void:
	reached_final_pos.emit()
	EventBus.visualiser_beat_passed.emit(PT.BeatQuality.NONE)
	_pressed = false
	_moving = false
	current_line = false
	_tween_fade_out(_miss_color)



func beat_pressed() -> void:
	reached_final_pos.emit()
	_pressed = true
	_moving = false
	current_line = false
	_tween_fade_out(_pressed_color)


func _tween_fade_out(color: Color) -> void:
	var invisible_color := color
	invisible_color.a = 0
	var t := create_tween()
	t.tween_property(self, "modulate", invisible_color,  0.6).from(color)
	await t.finished
	hide()


func start(sec_per_beat: float, starting_beat: int ) -> void:
	position.x = _final_x + (_dist * starting_beat)
	_time = sec_per_beat
	_moving = true
	show()
	if starting_beat != 1:
		var invisible_color := modulate
		invisible_color.a = 0
		var t := create_tween()
		t.tween_property(self, "modulate", modulate, _time * 0.5).from(invisible_color)
