extends Node2D
class_name ParryAttackRemover

var _visible_duration: float = 0.2
var _parry_from_enemy: bool = false

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _removerBox: Area2D = $RemoverBox

func prepare_attack_remover(appear_position: Vector2) -> void:
	global_position = appear_position


func set_parry_remover(from_enemy: bool) -> void: ## called by SkillParry
	if from_enemy:
		_removerBox.set_collision_mask_value(6, true)
		_removerBox.set_collision_mask_value(7, false)
	else:
		_removerBox.set_collision_mask_value(6, false)
		_removerBox.set_collision_mask_value(7, true)
	_parry_from_enemy = from_enemy ## for color


func activate() -> void:
	show()
	for area in _removerBox.get_overlapping_areas():
		if not area.owner:
			continue
		if area.owner is BaseProjectile:
			var p: BaseProjectile = area.owner
			p.queue_free()
	var t := create_tween()
	t.tween_property(_sprite, "scale", Vector2(4, 4), 
			_visible_duration).from(Vector2.ZERO)
	if _parry_from_enemy:
		t.parallel().tween_property(_sprite, "modulate", Color(1, 0.4, 0.2, 0.3), 
				_visible_duration).from(Color(1, 0.4, 0.2, 0.8))
	else:
		t.parallel().tween_property(_sprite, "modulate", Color(0.2, 0.4, 1, 0.3), 
				_visible_duration).from(Color(0.2, 0.4, 1, 0.8))
	await t.finished
	hide()
