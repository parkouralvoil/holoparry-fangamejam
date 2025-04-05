extends Node2D
class_name ProjectilePartOrbitingStar

var damage: int
var part_parryable: bool
var from_enemy: bool

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _projectile_hurtbox: ProjectileHurtbox = $ProjectileHurtbox

func _ready() -> void:
	_projectile_hurtbox.area_entered.connect(_on_area_entered)
	_projectile_hurtbox.body_entered.connect(_on_body_entered)
	_set_part_collisions()
	_change_colors()

func _change_colors() -> void:
	if from_enemy:
		if part_parryable:
			_sprite.modulate = Color.YELLOW
		else:
			_sprite.modulate = Color.ORANGE_RED
	else:
		if part_parryable:
			_sprite.modulate = Color.VIOLET
		else:
			_sprite.modulate = Color.SKY_BLUE


func _physics_process(delta: float) -> void:
	self.rotate(PI * delta)


func _set_part_collisions() -> void:
	_projectile_hurtbox.set_collisions(from_enemy, part_parryable)


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_body_entered(_body: Node2D) -> void: ## for wall collisions
	queue_free()
