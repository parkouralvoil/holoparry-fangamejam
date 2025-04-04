extends Node2D
class_name BaseMoveset

signal activated_parry() ## to get short iframes

@export var from_enemy: bool = false
var ui_resource_state: CharacterInfoState
var audio_parry: AudioStream

var _skill_array: Array[BaseSkill]

func assign_resource_state(resouce: CharacterInfoState) -> void:
	ui_resource_state = resouce ## called by Character/Enemy that owns this
	var dict: Dictionary[String, String] = {}
	for s in _skill_array:
		dict[s.string_combo] = s.skill_name
	ui_resource_state.set_skill_info(dict.duplicate())


func _ready() -> void:
	for node in get_children():
		if node is BaseSkill:
			node.set_skill_collisions(from_enemy)
			node.show()
			if from_enemy:
				node.attack_parriable_chance = clampf(node.attack_parriable_chance * 2, 0, 1)
			if node is SkillParry:
				var p: SkillParry = node
				p.successful_parry_skill.connect(_on_successful_parry_skill)
			#print_debug(node.name, node.combo, from_enemy)
			_skill_array.append(node)


func _process(delta: float) -> void:
	if not ui_resource_state:
		return
	if ui_resource_state.fever_active:
		ui_resource_state.fever -= 10.0 * delta



func try_activate_skill(performed_combo: Array[PT.Combo]) -> void:
	## function to check all skills in array, then activate skill if correct combo
	for skill in _skill_array:
		if skill.combo == performed_combo:
			#print_debug("skill found: ", skill.name)
			skill.activate_skill(ui_resource_state.fever_active)
			increase_fever(performed_combo.size())
			if skill is SkillParry:
				activated_parry.emit()
			return
	print_debug("no skill found")


func _on_successful_parry_skill() -> void:
	increase_fever(30)
	SoundPlayer.play_sound(audio_parry, 1)


func increase_fever(amt: float) -> void:
	if not ui_resource_state.fever_active:
		ui_resource_state.fever += amt


func enemy_use_skill(index: int) -> void:
	## for enemies to easily cast a skill
	var fever_mode := false
	if ui_resource_state: 
		fever_mode = ui_resource_state.fever_active
	if _skill_array.size() > index:
		increase_fever(index * 2)
		_skill_array[index].activate_skill(fever_mode)
