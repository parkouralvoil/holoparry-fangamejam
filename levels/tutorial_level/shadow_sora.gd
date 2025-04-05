extends Sprite2D


@export var _projectile_packed: PackedScene

@onready var _insta_killbox: Area2D = $InstaKillBox

func _ready() -> void:
	pass

func _on_firerate_timeout() -> void:
	_shoot(_projectile_packed,
		Vector2.DOWN,
		global_position,
		true,
		true
	)


func _shoot(projectile_packed: PackedScene, 
		dir: Vector2, 
		origin: Vector2,
		from_enemy: bool,
		parryable: bool) -> void:
	var p: BaseProjectile = projectile_packed.instantiate()
	p.direction = dir
	p.global_position = origin
	p.from_enemy = from_enemy
	p.damage = 5
	p.speed = 150
	p.parryable = parryable
	p.top_level = true
	add_child(p)


func _on_insta_kill_box_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(10000)
