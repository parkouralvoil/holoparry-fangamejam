extends Control

@onready var _main_hitMarker: TextureRect = $main_visual/Main
@onready var _main_animationPlayer: AnimationPlayer = _main_hitMarker.get_node("AnimationPlayer")
@onready var _left_animationPlayer: AnimationPlayer = $left_side_control/left.get_node("AnimationPlayer")
@onready var _right_animationPlayer: AnimationPlayer = $right_side_control/right.get_node("AnimationPlayer")

#hardcoded :/
var scale_hitmarker = (0.1 / (60.0/150.0)) + 0.05

func _ready() -> void:
	_left_animationPlayer.speed_scale = scale_hitmarker
	_right_animationPlayer.speed_scale = scale_hitmarker
	EventBus.beat_window_changed.connect(_on_beat_window_changed)
	
func _on_beat_window_changed(active: bool) -> void:
	if active:
		_main_animationPlayer.play("pulsating")
		_left_animationPlayer.play("left_hitmarker_to_main")
		_right_animationPlayer.play("right_hitmarker_to_main")
