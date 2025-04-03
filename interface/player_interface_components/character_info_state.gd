extends Resource
class_name CharacterInfoState

signal skill_info_changed()
signal hp_changed()
signal fever_changed()
signal died()

@export var max_hp: int = 150

var hp: int: ## needs onready so max_hp gets considered first
	set(val):
		hp = clampi(val, 0, max_hp)
		hp_changed.emit()

var skill_info: Dictionary[String, String] = {}

## fever is handled by moveset
var fever_active: bool = false
var fever: float = 0:
	set(val):
		fever = clampf(val, 0, max_fever)
		if fever == max_fever:
			fever_active = true
		elif fever == 0:
			fever_active = false
		fever_changed.emit()
var max_fever: float = 200

func initialize_hp() -> void: ## called by character/enemy
	hp = max_hp


func take_damage(dmg_received: int) -> void:
	hp -= dmg_received
	if hp <= 0:
		died.emit()


func set_skill_info(dict: Dictionary[String, String]) -> void:
	assert(dict.size() == 4)
	assert(dict.keys()[0] is String)
	assert(dict.values()[0] is String)
	skill_info = dict
	skill_info_changed.emit()
