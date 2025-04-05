extends Node2D
class_name RoundManager

@export var _tracked_state_player: CharacterInfoState
@export var _tracked_state_enemy: CharacterInfoState

var _player_resource_data: ResourceCharacterData
var _enemy_resource_data: ResourceCharacterData

var _player: BaseCharacter
var _enemy: BaseEnemy
var _freeze_frame_duration: float
var _game_finished: bool = false

@onready var _start_pos_player: Marker2D = $StartPosCharacter
@onready var _start_pos_enemy: Marker2D = $StartPosEnemy
@onready var _t_freeze_frame: FreezeFrame = $FreezeFrame

@onready var _player_interface: PlayerInterface = %PlayerInterface
@onready var _round_ui: RoundUI = %RoundUI


func _ready() -> void:
	assert(_tracked_state_player)
	assert(_tracked_state_enemy)
	_tracked_state_player.died.connect(_on_player_died)
	_tracked_state_enemy.died.connect(_on_enemy_died)
	_player_resource_data = GlobalCharacterData.get_character_player()
	_enemy_resource_data = GlobalCharacterData.get_character_AI()
	_round_ui.return_pressed.connect(_on_return_pressed)
	
	begin_game(_player_resource_data.character_scene, _enemy_resource_data.enemy_scene)
	_player_interface.update_portraits(_player_resource_data.portrait,
			_enemy_resource_data.portrait
		)


func begin_game(player_packed: PackedScene, enemy_packed: PackedScene) -> void:
	_player = player_packed.instantiate()
	_player.global_position = _start_pos_player.global_position
	_player.initialize_resource_state(_tracked_state_player)
	
	_enemy = enemy_packed.instantiate()
	_enemy.global_position = _start_pos_enemy.global_position
	_enemy.initialize_resource_state(_tracked_state_enemy)
	
	add_child(_player)
	add_child(_enemy)


func _on_player_died() -> void:
	if _game_finished:
		return
	_game_finished = true
	_player.defeated()
	await get_tree().physics_frame
	_t_freeze_frame.freeze_frame(_freeze_frame_duration)
	_game_ended("AI " + _enemy_resource_data.vtuber_name)


func _on_enemy_died() -> void:
	if _game_finished:
		return
	_game_finished = true
	_enemy.defeated()
	await get_tree().physics_frame
	_t_freeze_frame.freeze_frame(_freeze_frame_duration)
	_game_ended("Player " + _player_resource_data.vtuber_name)


func _game_ended(winner_name: String) -> void:
	_round_ui.show_winner(winner_name)


func _on_return_pressed() -> void:
	SceneLoader.goto_main_menu()
