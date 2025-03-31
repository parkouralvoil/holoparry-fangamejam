extends BaseSkill

@export var _ProjectilePacked: PackedScene

var damage: int = 5
var speed: float = 400

func activate_skill() -> void:
	var target_pos: Vector2
	var target_direction: Vector2
	var parriable: bool
	
	target_pos = CombatHelper.enemy_global_position if not _from_enemy \
		else CombatHelper.player_global_position
	target_direction = self.global_position.direction_to(target_pos)
		
	for i in range(4):
		parriable = (CombatHelper.RNG.randf() < attack_parriable_chance)
		
		_shoot(_ProjectilePacked, 
				target_direction, 
				self.global_position,
				_from_enemy,
				parriable)
		await get_tree().create_timer(0.25).timeout
		
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
