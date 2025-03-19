extends BaseSkill

@export var _ProjectilePacked: PackedScene

func activate_skill(from_enemy: bool = false) -> void:
	for i in range(3):
		var target_pos: Vector2 = CombatHelper.enemy_global_position if not from_enemy \
			else CombatHelper.player_global_position
		_shoot(_ProjectilePacked, 
				self.global_position.direction_to(target_pos), 
				self.global_position,
				from_enemy)
		await get_tree().create_timer(0.3).timeout


func _shoot(projectile_packed: PackedScene, 
		dir: Vector2, 
		origin: Vector2,
		from_enemy: bool) -> void:
	var p: BaseProjectile = projectile_packed.instantiate()
	p.direction = dir
	p.global_position = origin
	p.from_enemy = from_enemy
	p.top_level = true
	add_child(p)
