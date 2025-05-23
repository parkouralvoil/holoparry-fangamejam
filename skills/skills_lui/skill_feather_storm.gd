extends BaseSkill

@export var _ProjectilePacked: PackedScene

var damage: int = 10
var speed: float = 200

func activate_skill(fever_mode: bool) -> void:
	var target_pos: Vector2 = CombatHelper.enemy_global_position if not _from_enemy \
			else CombatHelper.player_global_position
	var target_direction: Vector2 = self.global_position.direction_to(target_pos)
	var offset_dir: Vector2
	var parriable: bool
	
	var volleys := 2 if not fever_mode else 4
	
	for volley in range(volleys):
		for i in range(-2, 3):
			parriable = (CombatHelper.RNG.randf() < attack_parriable_chance)
			var offset: float = 0.2 if volley % 2 == 0 else 0.0
			offset_dir = target_direction.rotated(offset + i * PI/10)
			_shoot(_ProjectilePacked, 
					offset_dir, 
					self.global_position + (20 * Vector2.RIGHT.rotated(offset_dir.angle())),
					_from_enemy,
					parriable)
		await get_tree().create_timer(0.35).timeout

func _shoot(projectile_packed: PackedScene, 
		dir: Vector2, 
		origin: Vector2,
		from_enemy: bool,
		parryable: bool) -> void:
	var p: BaseProjectile = projectile_packed.instantiate()
	p.direction = dir
	p.global_position = origin
	p.from_enemy = from_enemy
	p.damage = damage
	p.speed = speed
	p.parryable = parryable
	p.top_level = true
	add_child(p)
