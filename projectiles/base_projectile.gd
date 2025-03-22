extends Node2D
class_name BaseProjectile

@export var _Hurtbox: ProjectileHurtbox
@export var _Sprite: Sprite2D

@export_category("Projectile Stats")
@export var damage: float = 10
@export var speed: float = 250

var direction: Vector2 = Vector2.RIGHT
var from_enemy: bool = false
var parryable: bool = false


func _ready() -> void:
	_Hurtbox.area_entered.connect(_on_area_entered)
	_Hurtbox.body_entered.connect(_on_body_entered)
	if from_enemy:
		_Sprite.modulate = Color.ORANGE_RED
	_Hurtbox.set_collisions(from_enemy, parryable)


func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	rotation = direction.angle() + PI/2


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_body_entered(body: Node2D) -> void: ## for wall collisions
	queue_free()
