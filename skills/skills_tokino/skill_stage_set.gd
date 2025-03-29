extends BaseSkill

@export var _ProjectilePacked: PackedScene

var damage: int = 30
var speed: float = 160

func activate_skill() -> void:
	var target_pos: Vector2
	var target_direction: Vector2
	var parriable: bool
	
	target_pos = CombatHelper.enemy_global_position if not _from_enemy \
		else CombatHelper.player_global_position
	parriable = false
	if CombatHelper.RNG.randf() < attack_parriable_chance:
		parriable = true
	target_direction = self.global_position.direction_to(target_pos)
	_shoot(_ProjectilePacked, 
			target_direction, 
			self.global_position + (50 * Vector2.RIGHT.rotated(target_direction.angle())),
			_from_enemy,
			parriable)


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
