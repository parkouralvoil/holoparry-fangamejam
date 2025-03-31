extends Node2D
class_name BaseExplosion

@export var _Hurtbox: ProjectileHurtbox
@export var _Sprite: Sprite2D

var damage: float ## set by spawner

var from_enemy: bool = false
var parryable: bool = false

func _ready() -> void:
	_Hurtbox.area_entered.connect(_on_area_entered)
	if from_enemy:
		if parryable:
			_Sprite.modulate = Color.YELLOW
		else:
			_Sprite.modulate = Color.ORANGE_RED
	else:
		if parryable:
			_Sprite.modulate = Color.VIOLET
		else:
			_Sprite.modulate = Color.SKY_BLUE
	_Hurtbox.set_collisions(from_enemy, parryable)
	await _fade_out()
	queue_free()


func _fade_out() -> void:
	var final_color := _Sprite.modulate
	final_color.a = 0
	var t := create_tween()
	t.tween_property(_Sprite, "modulate", final_color, 0.5)
	await t.finished


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
