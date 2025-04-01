extends Control
class_name PlayerInterface

@onready var _ComboLabel: Label = %Combo
#@onready var _HPBar: ProgressBar = $HBoxContainer/VBoxContainer/HPBar

func _ready() -> void:
	##EventBus.beat_window_changed.connect(_on_beat_window_changed)
	EventBus.player_combo_updated.connect(_on_player_combo_updated)


func _convert_combo_to_string(c: PT.Combo) -> String:
	match c:
		PT.Combo.UP:
			return "UP"
		PT.Combo.DOWN:
			return "DOWN"
		_:
			return ""


func _on_player_combo_updated(new_combo: Array[PT.Combo]) -> void:
	var new_text: String = "Combo:"
	for c in new_combo:
		new_text = new_text + " " + _convert_combo_to_string(c)
	_ComboLabel.text = new_text
