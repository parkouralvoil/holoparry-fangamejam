extends Node2D
class_name BaseProjectile

@export var _Hurtbox: ProjectileHurtbox
@export var _Sprite: Sprite2D

@export_category("Projectile Stats") ## no longer export, these are set by the skills
var damage: int = 10
var speed: float = 250

var direction: Vector2 = Vector2.RIGHT
var from_enemy: bool = false
var parryable: bool = false


func _ready() -> void:
	_Hurtbox.area_entered.connect(_on_area_entered)
	_Hurtbox.body_entered.connect(_on_body_entered)
	if from_enemy:
		if parryable:
			_Sprite.modulate = Color.YELLOW
		else:
			_Sprite.modulate = Color.ORANGE_RED
	else:
		if parryable:
			_Sprite.modulate = Color.VIOLET
		else:
			_Sprite.modulate = Color.SKY_BLUE
	_Hurtbox.set_collisions(from_enemy, parryable)


func _physics_process(delta: float) -> void:
	## recommended to NOT change this
	_per_frame_movement(delta)
	_per_frame_visuals(delta)


func _per_frame_movement(delta: float) -> void:
	## change this for movement related stuff
	position += direction.normalized() * speed * delta


func _per_frame_visuals(_delta: float) -> void:
	## change this for purely visual stuff
	_Sprite.rotation = direction.angle() + PI/2



func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_body_entered(_body: Node2D) -> void: ## for wall collisions
	queue_free()
