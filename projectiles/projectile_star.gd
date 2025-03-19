extends Sprite2D

@onready var _Hitbox: Area2D = $Hitbox

var direction: Vector2 = Vector2.RIGHT
var speed: float = 50


func _ready() -> void:
	_Hitbox.area_entered.connect(_on_area_entered)
	_Hitbox.body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	rotation = direction.angle() + PI/2


func _on_area_entered(area: Area2D) -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
