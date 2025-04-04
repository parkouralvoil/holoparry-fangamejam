extends Node2D
class_name TutorialRoundManager

@export var _tracked_state_player: CharacterInfoState

@export var _tutorial_player_resource_data: ResourceCharacterData

var _player: BaseCharacter
var _freeze_frame_duration: float
var _game_finished: bool = false

@onready var _start_pos_player: Marker2D = $StartPosCharacter
@onready var _t_freeze_frame: FreezeFrame = $FreezeFrame
@onready var _player_interface: PlayerInterface = %PlayerInterface

@onready var _round_ui: RoundUI = %RoundUI


func _ready() -> void:
	assert(_tracked_state_player)
	_tracked_state_player.died.connect(_on_player_died)
	_round_ui.return_pressed.connect(_on_return_pressed)
	
	begin_game(_tutorial_player_resource_data.character_scene)


func begin_game(player_packed: PackedScene) -> void:
	_player = player_packed.instantiate()
	_player.global_position = _start_pos_player.global_position
	_player.initialize_resource_state(_tracked_state_player)
	_player_interface.set_tutorial_level_ui()
	
	add_child(_player)


func _on_player_died() -> void:
	if _game_finished:
		return
	_game_finished = true
	_player.defeated()
	await get_tree().physics_frame
	_t_freeze_frame.freeze_frame(_freeze_frame_duration)
	_game_ended("Tutorial Level")


func _game_ended(winner_name: String) -> void:
	_round_ui.show_winner(winner_name)


func _on_return_pressed() -> void:
	SceneLoader.goto_main_menu()
