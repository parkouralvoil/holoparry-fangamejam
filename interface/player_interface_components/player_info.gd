extends Control
class_name PlayerInfoUI

@export var _resource_state: CharacterInfoState

@onready var _label_parry: Label = %LabelParry
@onready var _label_skill_1: Label = %LabelSkill1
@onready var _label_skill_2: Label = %LabelSkill2
@onready var _label_skill_3: Label = %LabelSkill3

func _ready() -> void:
	assert(_resource_state)
	_resource_state.combo_changed.connect(_on_state_combo_changed)


func _on_state_combo_changed() -> void:
	_label_parry.text = "- Parry: " + _resource_state.combo_parry
	_label_skill_1.text = "- Skill 1: " + _resource_state.combo_skill_1
	_label_skill_2.text = "- Skill 2: " + _resource_state.combo_skill_2
	_label_skill_3.text = "- Skill 3: " + _resource_state.combo_skill_3
	print_debug("combo changed")
