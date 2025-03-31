extends Area2D
class_name AttackSpawnerBox

"""
like projectile hurtbox, but only for interacting with parry remover
"""

func set_parry_remover_collisions(from_enemy: bool) -> void:
	if from_enemy: ## projectile B
		_parry_removable_by_character()
	else:			## projectile A
		_parry_removable_by_enemy()


func _parry_removable_by_character() -> void:
	self.set_collision_layer_value(6, false)
	self.set_collision_layer_value(7, true)


func _parry_removable_by_enemy() -> void:
	self.set_collision_layer_value(6, true)
	self.set_collision_layer_value(7, false)
