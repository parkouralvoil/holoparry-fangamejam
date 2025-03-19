extends CharacterBody2D
class_name BaseEnemy

## Base character class for AI vtubers

@export var _Moveset: BaseMoveset
@export var _Hitbox: BaseHitbox
@export var _move_timer_duration: float

var _move_direction: Vector2
var _face_direction: Vector2 = _move_direction
var _speed: float = 100.0
var _rotation_speed: float = TAU * 4 # TAU is a full circle, this is 4 full rotations per sec
var _theta: float

var _attack_counter: int = 0
var _attack_threshold: int = 3

@onready var _Sprite: Sprite2D = $Sprite2D
@onready var _MoveTimer: Timer = $MoveTimer
@onready var _RNG: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	# this gets called at the start of the scene
	assert(_Moveset)
	assert(_Hitbox)
	EventBus.beat_window_changed.connect(_on_beat_window_changed)
	_Hitbox.got_hit.connect(_on_hit)
	_MoveTimer.start(_move_timer_duration)
	_MoveTimer.timeout.connect(_on_move_timer_timeout)


func _process(delta: float) -> void:
	CombatHelper.enemy_global_position = global_position


func _physics_process(delta: float) -> void:
	velocity = _move_direction.normalized() * _speed
	if _move_direction != Vector2.ZERO:
		_face_direction = _move_direction
	_theta = wrapf(atan2(_face_direction.y, _face_direction.x) - _Sprite.rotation + PI/2, 
			-PI, PI)
	_Sprite.rotation += clamp(_rotation_speed * delta, 0, abs(_theta)) * sign(_theta)
	move_and_slide()


func _on_beat_window_changed(active: bool) -> void:
	if active:
		if _attack_counter >= _attack_threshold:
			_Moveset.enemy_use_skill(1)
			_attack_counter = 0
		else:
			_attack_counter += 1


func _on_move_timer_timeout() -> void:
	var chance: float = _RNG.randf()
	if chance < 0.25:
		_move_direction = Vector2.RIGHT
	elif chance < 0.5:
		_move_direction = Vector2.UP
	elif chance < 0.75:
		_move_direction = Vector2.DOWN
	else:
		_move_direction = Vector2.LEFT


func _on_hit(dmg: float) -> void:
	print_debug("beep boop i got hit")
