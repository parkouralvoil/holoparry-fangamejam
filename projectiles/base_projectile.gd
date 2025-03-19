extends Node2D
class_name BaseProjectile

@export var _Hurtbox: Area2D
@export var _Sprite: Sprite2D

@export_category("Projectile Stats")
@export var damage: float = 10
@export var speed: float = 250

var direction: Vector2 = Vector2.RIGHT
var from_enemy: bool = false


func _ready() -> void:
	_Hurtbox.area_entered.connect(_on_area_entered)
	_Hurtbox.body_entered.connect(_on_body_entered)
	if from_enemy:
		## scan only character hitboxes
		_Hurtbox.set_collision_mask_value(2, true)
		_Sprite.modulate = Color.ORANGE_RED
	else:
		## scan only enemy hitboxes
		_Hurtbox.set_collision_mask_value(5, true)
	_Hurtbox.monitorable = true
	_Hurtbox.monitoring = true


func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	rotation = direction.angle() + PI/2


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_body_entered(body: Node2D) -> void: ## for wall collisions
	queue_free()
