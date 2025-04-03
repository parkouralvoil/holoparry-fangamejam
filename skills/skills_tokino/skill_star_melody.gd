extends BaseSkill

@export var _ProjectilePacked: PackedScene

var damage: int = 8
var speed: float = 280

func activate_skill(fever_mode: bool) -> void:
	var target_pos: Vector2
	var parriable: bool
	var stars := 3
	
	for i in range(stars):
		target_pos = CombatHelper.enemy_global_position if not _from_enemy \
			else CombatHelper.player_global_position
		parriable = false
		if CombatHelper.RNG.randf() < attack_parriable_chance:
			parriable = true
		_shoot(_ProjectilePacked, 
				self.global_position.direction_to(target_pos), 
				self.global_position,
				_from_enemy,
				parriable)
		if fever_mode:
			_shoot(_ProjectilePacked, 
				self.global_position.direction_to(target_pos).rotated(PI/10), 
				self.global_position,
				_from_enemy,
				parriable)
			_shoot(_ProjectilePacked, 
				self.global_position.direction_to(target_pos).rotated(-PI/10), 
				self.global_position,
				_from_enemy,
				parriable)
		await get_tree().create_timer(0.3).timeout


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
