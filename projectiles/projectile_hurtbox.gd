extends Area2D
class_name ProjectileHurtbox

"""
This hurtbox will only have a collision layers and masks once its set by its
parent BaseProjectile
"""

func set_collisions(from_enemy: bool, parryable: bool):
	_collide_with_world()
	if from_enemy: ## projectile B
		_target_character()
		if parryable: ## parryable projectile B
			_set_as_parryable_B()
	else:			## projectile A
		_target_enemy()
		if parryable: ## parryable projectile A
			_set_as_parryable_A()


func _collide_with_world() -> void:
	self.set_collision_mask_value(5, true)


func _target_character() -> void:
	self.set_collision_mask_value(1, true)
	self.set_collision_mask_value(2, false)
	self.set_collision_layer_value(6, false)
	self.set_collision_layer_value(7, true)


func _target_enemy() -> void:
	self.set_collision_mask_value(1, false)
	self.set_collision_mask_value(2, true)
	self.set_collision_layer_value(6, true)
	self.set_collision_layer_value(7, false)


func _set_as_parryable_A() -> void:
	self.set_collision_layer_value(3, true)
	self.set_collision_layer_value(4, false)


func _set_as_parryable_B() -> void:
	self.set_collision_layer_value(3, false)
	self.set_collision_layer_value(4, true)
