extends Control
class_name CharacterInfoUI

@export var _character_info_state: CharacterInfoState

@onready var _hp_bar: ProgressBar = %HPBar
@onready var _fever_bar: ProgressBar = %FeverBar
@onready var _cpu_partciles: CPUParticles2D = $CPUParticles2D
@onready var _char_portrait: TextureRect = %CharPortrait

func assign_character_portrait(portrait: Texture) -> void:
	_char_portrait.texture = portrait

func _ready() -> void:
	assert(_character_info_state)
	#_player_info_state.combo_changed.connect(_on_state_combo_changed)
	_character_info_state.hp_changed.connect(_on_hp_changed)
	_character_info_state.fever_changed.connect(_on_fever_changed)
	await get_tree().process_frame
	_update_hp_bar()
	_update_fever_bar()


func _update_hp_bar() -> void:
	_hp_bar.max_value = _character_info_state.max_hp
	_hp_bar.value = _character_info_state.hp


func _update_fever_bar() -> void:
	_fever_bar.max_value = _character_info_state.max_fever
	_fever_bar.value = _character_info_state.fever
	_cpu_partciles.emitting = _character_info_state.fever_active


func _on_hp_changed() -> void:
	_update_hp_bar()


func _on_fever_changed() -> void:
	_update_fever_bar()
