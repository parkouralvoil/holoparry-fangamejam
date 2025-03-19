extends BaseSkill

@export var _ProjectilePacked: PackedScene

func activate_skill() -> void:
	_shoot(_ProjectilePacked, Vector2.RIGHT, self.global_position)


func _shoot(projectile_packed: PackedScene, dir: Vector2, origin: Vector2) -> void:
	var p := projectile_packed.instantiate()
	p.direction = dir
	p.global_position = origin
	get_tree().root.add_child(p)
