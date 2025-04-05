extends GridContainer
class_name CharacterGrid

signal character_selected(char_data: ResourceCharacterData)

@export var _character_button_group: ButtonGroup

func _ready() -> void:
	assert(_character_button_group)
	var char_array: Array[ResourceCharacterData] = \
			GlobalCharacterData.get_character_data_array()
	for c in char_array:
		var button := Button.new()
		button.button_group = _character_button_group
		button.toggle_mode = true
		button.text = c.vtuber_name
		button.pressed.connect(_on_character_button_pressed.bind(c))
		add_child(button)


func _on_character_button_pressed(char_data: ResourceCharacterData) -> void:
	character_selected.emit(char_data)
