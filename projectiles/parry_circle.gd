extends Node2D
class_name ParryCircle

signal successful_parry()

var _active_duration: float = 0.5
var _emitted: bool = false
var _parry_from_enemy: bool = false
var _color: Color

@onready var _attackParryCheckbox: Area2D = $AttackParryCheckbox
@onready var _activeDurationTimer: Timer = $ActiveDuration
@onready var _sprite_during_parry: Sprite2D = $Sprite2D
@onready var _sprite_after_parry: Sprite2D = $SpriteAfterParry

func _ready() -> void:
	_attackParryCheckbox.area_entered.connect(_on_attackParryCheckbox_area_entered)
	_sprite_during_parry.hide()
	_sprite_after_parry.hide()


func set_parry_check(from_enemy: bool) -> void: ## called by SkillParry
	if from_enemy:
		_attackParryCheckbox.set_collision_mask_value(3, true)
		_attackParryCheckbox.set_collision_mask_value(4, false)
		_color = Color.FIREBRICK
	else:
		_attackParryCheckbox.set_collision_mask_value(3, false)
		_attackParryCheckbox.set_collision_mask_value(4, true)
		_color = Color.BLUE
	var parry_color := _color
	parry_color.a = 0.4
	_sprite_during_parry.modulate = parry_color
	_parry_from_enemy = from_enemy


func activate_parry_check(): ## called by SkillParry
	_attackParryCheckbox.monitoring = true
	_sprite_during_parry.show()
	_activeDurationTimer.start(_active_duration)
	await _activeDurationTimer.timeout
	_emitted = false
	_end_parry_check()


func _on_attackParryCheckbox_area_entered(area: Area2D) -> void:
	if area:
		if not area.owner:
			return
		if not _emitted:
			_emitted = true
			_end_parry_check()
			successful_parry.emit()
			_tween_circle_after_parry()


func _end_parry_check() -> void:
	_attackParryCheckbox.set_deferred("monitoring", false)
	_sprite_during_parry.hide()


func _tween_circle_after_parry() -> void:
	var t := create_tween()
	var duration: float = 0.8
	
	var starting_color := _color
	var final_color := _color
	starting_color.a = 0.6
	final_color.a = 0.1
	
	_sprite_after_parry.show()
	if _parry_from_enemy:
		t.parallel().tween_property(_sprite_after_parry, "modulate", final_color, 
				duration).from(starting_color)
	else:
		t.parallel().tween_property(_sprite_after_parry, "modulate", final_color, 
				duration).from(starting_color)
	await  t.finished
	_sprite_after_parry.hide()
