extends HBoxContainer
class_name SkillInfoBox

var _combo_arrows: Array[ComboArrow] = []

@onready var _label := $Label

func _ready() -> void:
	for c in get_children():
		if c is ComboArrow:
			_combo_arrows.append(c)
	assert(_combo_arrows.size() == 4)


func set_info(combo_string: String, skill_name: String) -> void:
	_label.text = skill_name + ":"
	var arr: Array[PT.Combo] = PT.string_to_array_combo(combo_string)
	var arr_size := arr.size()
	for i in range(_combo_arrows.size()):
		if i < arr_size:
			_combo_arrows[i].change_arrow(arr[i])
			_combo_arrows[i].show()
		else:
			_combo_arrows[i].hide()
