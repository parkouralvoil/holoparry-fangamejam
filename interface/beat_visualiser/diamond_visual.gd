extends Control
class_name DiamondVisual

var _first_beat: bool
var _tween: Tween

@onready var _left_side_lines: DiamondLinesManager = $LeftSideLines
@onready var _right_side_lines: DiamondLinesManager = $RightSideLines

@onready var _main_diamond: TextureRect = $MainDiamond

func _ready() -> void:
	_first_beat = false
	EventBus.beat_update.connect(_on_beat_update)


func _on_beat_update() -> void:
	_left_side_lines.spawn_line(_first_beat)
	_right_side_lines.spawn_line(_first_beat)
	if _first_beat:
		_first_beat = false
		return
	if _tween:
		_tween.stop()
	_tween = create_tween()
	_tween.tween_property(_main_diamond, "scale", Vector2(1, 1), 0.1).from(Vector2(1.15, 1.15))
