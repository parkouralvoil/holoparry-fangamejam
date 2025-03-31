extends BaseSkill

## spawns 3 explosions near target with a 1 second delay before boom
@export var _SpawnerPacked: PackedScene

var damage: int = 30

func activate_skill() -> void:
	var target_pos: Vector2
	var parriable: bool
	
	target_pos = CombatHelper.enemy_global_position if not _from_enemy \
		else CombatHelper.player_global_position
		
	parriable = (CombatHelper.RNG.randf() < attack_parriable_chance)
	
	_place_spawner(_SpawnerPacked,
			target_pos,
			_from_enemy,
			parriable)
	#await get_tree().create_timer(0.25).timeout


func _place_spawner(spawner_packed: PackedScene, 
		target: Vector2,
		from_enemy: bool,
		parryable: bool) -> void:
	var s: AttackSpawner = spawner_packed.instantiate()
	s.global_position = target
	s.from_enemy = from_enemy
	s.damage = damage
	s.parryable = parryable
	s.top_level = true
	add_child(s)
