extends Control
class_name PlayerInterface

@export var _player_info_state: CharacterInfoState

var _combo_arrows: Array[ComboArrow] = []
var _skill_combo_info_boxes: Array[SkillInfoBox] = []
var _player_moveset_skill_info: Dictionary[String, String] = {}

@onready var _SkillComboInfos: HBoxContainer = %SkillComboInfos 
@onready var _ComboHBox: HBoxContainer = %ComboHBox
@onready var _AvailableSkill: Label = %AvailableSkill

@onready var _enemy_info: CharacterInfoUI = $EnemyInfo
#@onready var _HPBar: ProgressBar = $HBoxContainer/VBoxContainer/HPBar

func _ready() -> void:
	##EventBus.beat_window_changed.connect(_on_beat_window_changed)
	EventBus.player_combo_updated.connect(_on_player_combo_updated)
	_player_info_state.skill_info_changed.connect(_on_skill_info_changed)
	for c in _ComboHBox.get_children():
		if c is ComboArrow:
			_combo_arrows.append(c)
			c.hide()
	for c in _SkillComboInfos.get_children():
		if c is SkillInfoBox:
			_skill_combo_info_boxes.append(c)


func _on_player_combo_updated(new_combo: Array[PT.Combo]) -> void:
	var arr_size := new_combo.size()
	assert(arr_size <= 4, "plyer combo too large")
	for i in range(_combo_arrows.size()):
		if i < arr_size:
			_combo_arrows[i].show()
			_combo_arrows[i].change_arrow(new_combo[i])
		else:
			_combo_arrows[i].hide()
	if _player_info_state:
		var combo_string := PT.array_combo_to_string(new_combo)
		if _player_moveset_skill_info.has(combo_string):
			_AvailableSkill.text = _player_moveset_skill_info[combo_string]
		else:
			_AvailableSkill.text = ""


func _on_skill_info_changed() -> void:
	_player_moveset_skill_info = _player_info_state.skill_info
	var keys: Array[String] = _player_moveset_skill_info.keys()
	var i := 0
	for key in keys:
		var val := _player_moveset_skill_info[key]
		_skill_combo_info_boxes[i].set_info(key, val)
		i += 1


func set_tutorial_level_ui() -> void:
	_enemy_info.hide()
