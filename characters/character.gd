extends CharacterBody2D
class_name BaseCharacter

## Base character class for controllable vtubers

@export var Moveset: Node2D
@export var Hitbox: CharacterHitbox


var _move_direction: Vector2
var _speed: float = 250.0
var _beat_window_active: bool = false

func _ready() -> void:
	# this gets called at the start of the scene
	assert(Hitbox)
	EventBus.beat_window_changed.connect(_on_beat_window_changed)
	Hitbox.got_hit.connect(_on_hit)


func _process(delta: float) -> void:
	# this gets called every frame
	if Input.is_action_pressed("move_up"):
		_move_direction.y = -1
	elif Input.is_action_pressed("move_down"):
		_move_direction.y = 1
	else:
		_move_direction.y = 0
	
	if Input.is_action_pressed("move_left"):
		_move_direction.x = -1
	elif Input.is_action_pressed("move_right"):
		_move_direction.x = 1
	else:
		_move_direction.x = 0
		
	if Input.is_action_just_pressed("beat_activate"):
		
		print_debug(_is_action_on_beat())

func _on_beat_window_changed(active: bool) -> void:
	_beat_window_active = active

func _is_action_on_beat() -> bool:
	return _beat_window_active

func _physics_process(delta: float) -> void:
	velocity = _move_direction * _speed
	move_and_slide()


func _on_hit() -> void:
	print_debug("ouch i got hit")
