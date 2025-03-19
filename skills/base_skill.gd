extends Node2D
class_name BaseSkill

@export var skill_name: String
@export var skill_cooldown: float
@export var _combo: String ## example: 101 means UP DOWN UP
var combo: Array[PT.Combo]

func _ready() -> void:
	## set combo:
	assert(_combo.count("0") + _combo.count("1") == _combo.length(),
			"Invalid combo set for %s" % name)
	for c in _combo:
		if c == "0":
			combo.append(PT.Combo.DOWN)
		else:
			combo.append(PT.Combo.UP)


func activate_skill(from_enemy: bool = false) -> void:
	pass
