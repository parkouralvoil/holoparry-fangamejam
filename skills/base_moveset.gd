extends Node2D
class_name BaseMoveset

var _skill_array: Array[BaseSkill]

func _ready() -> void:
	for node in get_children():
		if node is BaseSkill:
			_skill_array.append(node)


func try_activate_skill(performed_combo: Array[PT.Combo]) -> void:
	## function to check all skills in array, then activate skill if correct combo
	for skill in _skill_array:
		if skill.combo == performed_combo:
			print_debug("skill found: ", skill.name)
			skill.activate_skill()
			return
	print_debug("no skill found")


func enemy_use_skill(index: int) -> void:
	## for enemies to easily cast a skill
	if _skill_array.size() > index:
		_skill_array[index].activate_skill(true)
