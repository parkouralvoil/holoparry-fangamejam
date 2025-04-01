extends TextureRect
class_name DiamondLine

@export var _is_left_line: bool = true
var _final_x: float
var _dist: float

var _speed: float
var _time: float = 1

var _active: bool = false
var _pressed: bool = false

var _default_color := Color(1, 1, 1, 1)

func _ready() -> void:
	if _is_left_line:
		_final_x = 0
		_dist = -90
	else:
		_final_x = 39
		_dist = 90

func _physics_process(delta: float) -> void:
	if not _active:
		return
	_speed = (_dist/_time) * delta
	if _is_left_line:
		position.x = min(position.x - _speed, _final_x)
		## offset is to ensure its ready during the next beat
		if (position.x >= _final_x and _pressed) or (position.x >= _final_x + 15):
			_reset_line()
	else:
		position.x = max(position.x - _speed, _final_x)
		if (position.x <= _final_x and _pressed) or (position.x <= _final_x - 15):
			_reset_line()


func _reset_line() -> void:
	_pressed = false
	hide()


func beat_pressed() -> void:
	hide()
	_pressed = true


func start(starting_beat: int, sec_per_beat: float ) -> void:
	position.x = _final_x + (_dist * starting_beat)
	_time = sec_per_beat
	_active = true
	show()
	if starting_beat != 1:
		var invisible_color := _default_color
		invisible_color.a = 0
		var t := create_tween()
		t.tween_property(self, "modulate", _default_color, _time * 0.5).from(
			invisible_color
			)
