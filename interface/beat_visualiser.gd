extends Control

@onready var _hitMarker: TextureRect = $CenterContainer/TextureRect
@onready var _animationPlayer: AnimationPlayer = _hitMarker.get_node("AnimationPlayer")

func _ready() -> void:
	EventBus.beat_window_changed.connect(_on_beat_window_changed)
	
func _on_beat_window_changed(active: bool) -> void:
	if active:
		_animationPlayer.play("pulsating")
