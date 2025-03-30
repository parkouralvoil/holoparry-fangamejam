extends Resource
class_name CharacterInfoState

signal combo_changed()
signal hp_changed()
signal died()

@export var max_hp: int = 150

var hp: int: ## needs onready so max_hp gets considered first
	set(val):
		hp = clampi(val, 0, max_hp)
		hp_changed.emit()

var combo_parry: String: 
	set(str):
		combo_parry = str
		combo_changed.emit()
var combo_skill_1: String: 
	set(str):
		combo_skill_1 = str
		combo_changed.emit()
var combo_skill_2: String: 
	set(str):
		combo_skill_2 = str
		combo_changed.emit()
var combo_skill_3: String: 
	set(str):
		combo_skill_3 = str
		combo_changed.emit()


func initialize_hp() -> void: ## called by character/enemy
	hp = max_hp


func take_damage(dmg_received: int) -> void:
	hp -= dmg_received
	if hp <= 0:
		died.emit()
