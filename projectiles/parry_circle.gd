extends Node2D
class_name ParryCircle

signal successful_parry()

var _active_duration: float = 0.5
var _emitted: bool = false

@onready var _attackParryCheckbox: Area2D = $AttackParryCheckbox
@onready var _activeDurationTimer: Timer = $ActiveDuration

func _ready() -> void:
	_attackParryCheckbox.area_entered.connect(_on_attackParryCheckbox_area_entered)


func set_parry_check(from_enemy: bool) -> void: ## called by SkillParry
	if from_enemy:
		_attackParryCheckbox.set_collision_mask_value(3, true)
		_attackParryCheckbox.set_collision_mask_value(4, false)
	else:
		_attackParryCheckbox.set_collision_mask_value(3, false)
		_attackParryCheckbox.set_collision_mask_value(4, true)


func activate_parry_check(): ## called by SkillParry
	_attackParryCheckbox.monitoring = true
	show()
	_activeDurationTimer.start(_active_duration)
	await _activeDurationTimer.timeout
	_emitted = false
	_end_parry_check()


func _on_attackParryCheckbox_area_entered(area: Area2D) -> void:
	if area:
		if not area.owner:
			return
		if area.owner is BaseProjectile:
			var p: BaseProjectile = area.owner
			if not _emitted:
				_emitted = true
				_end_parry_check()
				successful_parry.emit()


func _end_parry_check():
	_attackParryCheckbox.set_deferred("monitoring", false)
	hide()
