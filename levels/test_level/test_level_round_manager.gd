extends Node2D
class_name TestLevelRoundManager

@export_category("DEBUG STUFF")
@export var _selected_player: PackedScene
@export var _selected_enemy: PackedScene

@export var _tracked_state_player: CharacterInfoState
@export var _tracked_state_enemy: CharacterInfoState

var _player: BaseCharacter
var _enemy: BaseEnemy
var _freeze_frame_duration: float
var _game_finished: bool = false

@onready var _start_pos_player: Marker2D = $StartPosCharacter
@onready var _start_pos_enemy: Marker2D = $StartPosEnemy
@onready var _t_freeze_frame: FreezeFrame = $FreezeFrame


func _ready() -> void:
	## DEBUG STUFF
	assert(_selected_player)
	assert(_selected_enemy)
	assert(_tracked_state_player)
	assert(_tracked_state_enemy)
	_tracked_state_player.died.connect(_on_player_died)
	_tracked_state_enemy.died.connect(_on_enemy_died)
	#_t_freeze_frame.timeout.connect(_on_t_freeze_frame_timeout)
	begin_game()
	


func begin_game() -> void:
	_player = _selected_player.instantiate()
	_player.global_position = _start_pos_player.global_position
	_player.initialize_resource_state(_tracked_state_player)
	
	_enemy = _selected_enemy.instantiate()
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
	_game_ended("AI Tokino")

func _on_enemy_died() -> void:
	if _game_finished:
		return
	_game_finished = true
	_enemy.defeated()
	await get_tree().physics_frame
	_t_freeze_frame.freeze_frame(_freeze_frame_duration)
	_game_ended("Tokino Sora")


func _game_ended(winner_name: String) -> void:
	print_debug(winner_name + " wins!")
