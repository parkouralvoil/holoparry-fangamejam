extends Node

var _character_data_array: Array[ResourceCharacterData] = [
	load("res://data/resource_character_data/data_TokinoSora.tres"),
	load("res://data/resource_character_data/data_TakaneLui.tres"),
]

var _selected_character_player: ResourceCharacterData
var _selected_character_AI: ResourceCharacterData


func get_character_player() -> ResourceCharacterData:
	return _selected_character_player

func get_character_AI() -> ResourceCharacterData:
	return _selected_character_AI

func set_character_player(char_data: ResourceCharacterData) -> void:
	_selected_character_player = char_data

func set_character_AI(char_data: ResourceCharacterData) -> void:
	_selected_character_AI = char_data

func all_characters_set() -> bool:
	if _selected_character_player and _selected_character_AI:
		return true
	return false

func get_character_data_array() -> Array[ResourceCharacterData]:
	var copy := _character_data_array.duplicate()
	return copy
