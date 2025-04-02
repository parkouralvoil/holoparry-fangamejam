extends Control
class_name DiamondVisual

var _first_beat: bool = true
var _tween: Tween

@onready var _left_side_lines: DiamondLinesManager = $LeftSideLines
@onready var _right_side_lines: DiamondLinesManager = $RightSideLines

@onready var _main_diamond: TextureRect = $MainDiamond


func update_beat_animation() -> void:
	_left_side_lines.spawn_line(_first_beat)
	_right_side_lines.spawn_line(_first_beat)
	if _first_beat:
		_first_beat = false
		return
	if _tween:
		_tween.stop()
	_tween = create_tween()
	_tween.tween_property(_main_diamond, "scale", Vector2(1, 1), 0.2).from(Vector2(1.15, 1.15))


func get_remaining_distance() -> float:
	var output := _right_side_lines.get_remaining_distance()
	return output
