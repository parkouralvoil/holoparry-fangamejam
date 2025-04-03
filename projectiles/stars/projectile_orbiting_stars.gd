extends BaseProjectile
class_name ProjectileOrbitingStars

"""
This node is special as it doesnt have a collision shape for the hurtbox
- making it dependent on DespawnCheck to queue free itself once all part_stars have collided
- parry cannot detect nor remove this node, but it can detect/remove the part_stars
- parryable_chance is used instead of parryable
"""

@export var _PartOrbitingStarPacked: PackedScene

var num_of_stars: int
var starting_distance: float
var parryable_chance: float

@onready var _stars: Node2D = $Stars

func _ready() -> void:
	super()
	assert(_PartOrbitingStarPacked)
	for i in range(num_of_stars):
		var part_star: ProjectilePartOrbitingStar = _PartOrbitingStarPacked.instantiate()
		var part_parryable: bool = (CombatHelper.RNG.randf() < parryable_chance)
		part_star.damage = damage
		part_star.from_enemy = from_enemy
		part_star.part_parryable = part_parryable
		part_star.position = Vector2.RIGHT.rotated(TAU * i / num_of_stars) * starting_distance
		_stars.add_child(part_star)


func _per_frame_movement(delta: float) -> void:
	position += direction.normalized() * speed * delta
	_stars.rotate(delta * PI/2)


func _on_despawn_check_timeout() -> void:
	if _stars.get_child_count() <= 0:
		queue_free()
