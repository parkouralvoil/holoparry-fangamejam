extends Control
class_name RoundUI

signal return_pressed()


@onready var _round_info: CenterContainer = $CenterContainer
@onready var _label_winner: Label = %Winner
@onready var _return_button: Button = %ReturnButton


func _ready() -> void:
	_round_info.hide()
	_return_button.disabled = true


func show_winner(winner_name: String) -> void:
	_round_info.modulate = Color(1, 1, 1, 0)
	_label_winner.text = winner_name + " WINS!"
	var t := create_tween()
	t.tween_property(_round_info, "modulate", Color(1, 1, 1, 1), 1)
	_round_info.show()
	await t.finished
	_return_button.disabled = false


func _on_return_button_pressed() -> void:
	return_pressed.emit()
