extends MarginContainer

@export var _AI_levelPackedScene: PackedScene

@onready var _PlayerGrid: CharacterGrid = %PlayerGrid
@onready var _EnemyGrid: CharacterGrid = %EnemyGrid
@onready var _StartButton: Button = %Start


func _ready() -> void:
	assert(_AI_levelPackedScene)
	_PlayerGrid.character_selected.connect(_on_player_character_selected)
	_EnemyGrid.character_selected.connect(_on_enemy_character_selected)
	_StartButton.pressed.connect(_on_start_pressed)
	if not GlobalCharacterData.all_characters_set():
		_StartButton.disabled = true

func _on_player_character_selected(char_data: ResourceCharacterData) -> void:
	GlobalCharacterData.set_character_player(char_data)
	if GlobalCharacterData.all_characters_set():
		_StartButton.disabled = false


func _on_enemy_character_selected(char_data: ResourceCharacterData) -> void:
	GlobalCharacterData.set_character_AI(char_data)
	if GlobalCharacterData.all_characters_set():
		_StartButton.disabled = false


func _on_start_pressed() -> void:
	if GlobalCharacterData.all_characters_set():
		get_tree().change_scene_to_packed(_AI_levelPackedScene)
