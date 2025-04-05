extends Control
class_name DiamondLinesManager

var _lines_array: Array[DiamondLine]

var _current_index: int = 0
var _next_spawn_index: int = 0

var _num_of_lines: int = 4

func _ready() -> void:
	for c in get_children():
		if c is DiamondLine:
			var line := c
			_lines_array.append(line)
			line.reached_final_pos.connect(_on_line_reached_final_pos)
			line.hide()
	assert(_lines_array.size() == _num_of_lines)
	EventBus.combo_or_skill_pressed.connect(_on_combo_or_skill_pressed)


func _start_line(sec_per_beat: float, starting_beat: int) -> void:
	var l: DiamondLine = _lines_array[_next_spawn_index]
	l.start(sec_per_beat, starting_beat)
	_next_spawn_index = (_next_spawn_index + 1) % _num_of_lines
	if starting_beat == 1:
		l.current_line = true


func spawn_line(first_beat: bool) -> void:
	if first_beat:
		_start_line(Conductor.sec_per_beat, 1)
		_start_line(Conductor.sec_per_beat, 2)
	else:
		_start_line(Conductor.sec_per_beat, 2)


func get_remaining_distance() -> float:
	var l := _lines_array[_current_index]
	var final_pos := l._final_x
	var current_pos := l.position.x
	if l._is_left_line:
		return -(current_pos - final_pos)
	else:
		return current_pos - final_pos
"""
Right side:
	final pos = 33
	late offset = 21
	perfect = [33, 43], 0 <= difference <= 10
	late = [21, 33),  -12 <= difference < 0
	early = [43, 73], 10 < difference < 30
"""

func _on_line_reached_final_pos() -> void:
	_current_index = (_current_index + 1) % _num_of_lines
	_lines_array[_current_index].current_line = true


func _on_combo_or_skill_pressed(_beat_quality: PT.BeatQuality) -> void:
	_lines_array[_current_index].beat_pressed()
