extends MarginContainer

@onready var _PlayerGrid: CharacterGrid = %PlayerGrid
@onready var _PlayerMoveset: CharacterMovesetUI = %PlayerMoveset

@onready var _EnemyGrid: CharacterGrid = %EnemyGrid
@onready var _EnemyMoveset: CharacterMovesetUI = %EnemyMoveset

@onready var _StartButton: Button = %Start

func _ready() -> void:
	_PlayerGrid.character_selected.connect(_on_player_character_selected)
	_EnemyGrid.character_selected.connect(_on_enemy_character_selected)
	_StartButton.pressed.connect(_on_start_pressed)
	_PlayerMoveset.flip_portrait()
	if not GlobalCharacterData.all_characters_set():
		_StartButton.disabled = true

func _on_player_character_selected(char_data: ResourceCharacterData) -> void:
	GlobalCharacterData.set_character_player(char_data)
	_PlayerMoveset.update_display(char_data.portrait,
		char_data.skill_names,
		char_data.skill_desc,)
	if GlobalCharacterData.all_characters_set():
		_StartButton.disabled = false


func _on_enemy_character_selected(char_data: ResourceCharacterData) -> void:
	GlobalCharacterData.set_character_AI(char_data)
	_EnemyMoveset.update_display(char_data.portrait,
		char_data.skill_names,
		char_data.skill_desc,)
	if GlobalCharacterData.all_characters_set():
		_StartButton.disabled = false


func _on_start_pressed() -> void:
	if GlobalCharacterData.all_characters_set():
		SceneLoader.goto_ai_level()
