extends BaseSkill

@export var _ProjectilePacked: PackedScene

var damage: int = 5
var speed: float = 200

func activate_skill() -> void:
	var target_pos: Vector2 = CombatHelper.enemy_global_position if not _from_enemy \
			else CombatHelper.player_global_position
	var target_direction: Vector2 = self.global_position.direction_to(target_pos)
	var parriable: bool
	
	var number_of_bullets := 16
	
	for i in range(number_of_bullets):
		parriable = (CombatHelper.RNG.randf() < attack_parriable_chance)
		
		_shoot(_ProjectilePacked, 
				target_direction.rotated(TAU * i / number_of_bullets), 
				self.global_position,
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
