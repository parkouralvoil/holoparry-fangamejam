extends Node2D
class_name BaseMoveset

@export var from_enemy: bool = false
var ui_resource_state: CharacterInfoState

var _skill_array: Array[BaseSkill]

func assign_resource_state(resouce: CharacterInfoState) -> void:
	ui_resource_state = resouce ## called by Character/Enemy that owns this
	if ui_resource_state:
		await get_tree().process_frame ## HACK: give time for player_interface to load its resources
		ui_resource_state.combo_parry = _skill_array[0].string_combo
		ui_resource_state.combo_skill_1 = _skill_array[1].string_combo
		ui_resource_state.combo_skill_2 = _skill_array[2].string_combo
		ui_resource_state.combo_skill_3 = _skill_array[3].string_combo

func _ready() -> void:
	for node in get_children():
		if node is BaseSkill:
			node.set_skill_collisions(from_enemy)
			node.show()
			if from_enemy:
				node.attack_parriable_chance = clampf(node.attack_parriable_chance * 2, 0, 1)
			#print_debug(node.name, node.combo, from_enemy)
			_skill_array.append(node)


func try_activate_skill(performed_combo: Array[PT.Combo]) -> void:
	## function to check all skills in array, then activate skill if correct combo
	for skill in _skill_array:
		if skill.combo == performed_combo:
			#print_debug("skill found: ", skill.name)
			skill.activate_skill()
			return
	print_debug("no skill found")


func enemy_use_skill(index: int) -> void:
	## for enemies to easily cast a skill
	if _skill_array.size() > index:
		_skill_array[index].activate_skill()
