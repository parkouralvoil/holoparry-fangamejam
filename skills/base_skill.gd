extends Node2D
class_name BaseSkill

@export var skill_name: String
@export var skill_cooldown: float
@export var string_combo: String ## example: 101 means UP DOWN UP
@export_range(0, 1) var attack_parriable_chance: float ## parry skill excluded
var combo: Array[PT.Combo]
var _from_enemy: bool

func _ready() -> void:
	## set combo:
	assert(string_combo.count("0") + string_combo.count("1") == string_combo.length(),
			"Invalid combo set for %s" % name)
	for c in string_combo:
		if c == "0":
			combo.append(PT.Combo.DOWN)
		else:
			combo.append(PT.Combo.UP)
	#print_debug(_combo)


func set_skill_collisions(from_enemy: bool) -> void: ## set by BaseMoveset
	_from_enemy = from_enemy


func activate_skill() -> void:
	pass
