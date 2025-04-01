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
	assert(_lines_array.size() == _num_of_lines)


func _start_line(sec_per_beat: float, starting_beat: int = 2) -> void:
	var l: DiamondLine = _lines_array[_next_spawn_index]
	l.start(sec_per_beat, starting_beat)
	_next_spawn_index = (_next_spawn_index + 1) % _num_of_lines


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
		return -(final_pos - current_pos)
	else:
		return final_pos - current_pos
	## PERFECT/EARLY left: -(0 + 10) = -10
	## LATE left: -(0 - 10) = 10
	
	## PERFECT/EARLY right: 39 - 49 = -10
	## LATE right: 39 - 29 = 10
