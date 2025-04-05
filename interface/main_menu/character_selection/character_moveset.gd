extends MarginContainer
class_name CharacterMovesetUI

@onready var _char_portrait: TextureRect = %CharPortrait
@onready var _skill_names: Label = %skill_names
@onready var _skill_desc: Label = %skill_desc


func update_display(portrait: Texture, skill_names: String, desc: String) -> void:
	_char_portrait.texture = portrait
	_skill_names.text = skill_names
	_skill_desc.text = desc
