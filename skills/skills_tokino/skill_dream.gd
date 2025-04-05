extends BaseSkill

@export var _ProjectilePacked: PackedScene

var damage: int = 10
var speed: float = 180

func activate_skill(fever_mode: bool) -> void:
	var target_pos: Vector2 = CombatHelper.enemy_global_position if not _from_enemy \
			else CombatHelper.player_global_position
	var target_direction: Vector2
	var parriable_chance: float = 0.2
	
	target_direction = self.global_position.direction_to(target_pos)
	_shoot_ring(_ProjectilePacked, 
			target_direction, 
			self.global_position,
			_from_enemy,
			parriable_chance,
			6,
			90)
	if fever_mode:
		_shoot_ring(_ProjectilePacked, 
				target_direction, 
				self.global_position,
				_from_enemy,
				parriable_chance,
				8,
				160)


func _shoot_ring(projectile_packed: PackedScene, 
		dir: Vector2, 
		origin: Vector2,
		from_enemy: bool,
		parryable_chance: float,
		num_of_stars: int,
		starting_distance: float) -> void:
	var p: ProjectileOrbitingStars = projectile_packed.instantiate()
	p.direction = dir
	p.global_position = origin
	p.from_enemy = from_enemy
	p.damage = damage
	p.speed = speed
	p.num_of_stars = num_of_stars
	p.starting_distance = starting_distance
	p.parryable_chance = parryable_chance
	p.top_level = true
	add_child(p)
