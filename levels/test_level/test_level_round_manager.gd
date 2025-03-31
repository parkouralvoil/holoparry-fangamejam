extends Node2D
class_name TestLevelRoundManager

@export_category("DEBUG STUFF")
@export var _selected_player: PackedScene
@export var _selected_enemy: PackedScene

@export var _tracked_state_player: CharacterInfoState
@export var _tracked_state_enemy: CharacterInfoState

var _player: BaseCharacter
var _enemy: BaseEnemy

@onready var _start_pos_player: Marker2D = $StartPosCharacter
@onready var _start_pos_enemy: Marker2D = $StartPosEnemy


func _ready() -> void:
	## DEBUG STUFF
	assert(_selected_player)
	assert(_selected_enemy)
	assert(_tracked_state_player)
	assert(_tracked_state_enemy)
	_tracked_state_player.died.connect(_on_player_died)
	_tracked_state_enemy.died.connect(_on_enemy_died)
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
	_player.queue_free()
	_game_ended("AI Tokino")

func _on_enemy_died() -> void:
	_enemy.queue_free()
	_game_ended("Tokino Sora")


func _game_ended(winner_name: String) -> void:
	print_debug(winner_name + " wins!")
