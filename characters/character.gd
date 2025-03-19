extends CharacterBody2D
class_name BaseCharacter

## Base character class for controllable vtubers

@export var _Moveset: BaseMoveset
@export var _Hitbox: BaseHitbox


var _move_direction: Vector2
var _face_direction: Vector2 = _move_direction
var _speed: float = 250.0
var _beat_window_active: bool = false
var _player_combo: Array[PT.Combo] = []:
	set(val):
		_player_combo = val
		print_debug("hello")
var _rotation_speed: float = TAU * 4 # TAU is a full circle, this is 4 full rotations per sec
var _theta: float

@onready var _Sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# this gets called at the start of the scene
	assert(_Moveset)
	assert(_Hitbox)
	EventBus.beat_window_changed.connect(_on_beat_window_changed)
	_Hitbox.got_hit.connect(_on_hit)


func _process(delta: float) -> void:
	# this gets called every frame
	CombatHelper.player_global_position = global_position
	_check_move_input()
	_check_combo_skill_input()

func _check_combo_skill_input() -> void:
	if Input.is_action_just_pressed("beat_activate"):
		if _is_action_on_beat():
			_perform_combo()
		else:
			_clear_combo()
	if Input.is_action_just_pressed("combo_up"):
		if _is_action_on_beat():
			_add_combo(PT.Combo.UP)
		else:
			_clear_combo()
	if Input.is_action_just_pressed("combo_down"):
		if _is_action_on_beat():
			_add_combo(PT.Combo.DOWN)
		else:
			_clear_combo()


func _perform_combo() -> void:
	_Moveset.try_activate_skill(_player_combo)
	_clear_combo()


func _add_combo(c: PT.Combo) -> void:
	_player_combo.append(c)
	EventBus.player_combo_updated.emit(_player_combo)


func _clear_combo() -> void:
	_player_combo.clear()
	EventBus.player_combo_updated.emit(_player_combo)


func _physics_process(delta: float) -> void:
	velocity = _move_direction.normalized() * _speed
	if _move_direction != Vector2.ZERO:
		_face_direction = _move_direction
	_theta = wrapf(atan2(_face_direction.y, _face_direction.x) - _Sprite.rotation + PI/2, 
			-PI, PI)
	_Sprite.rotation += clamp(_rotation_speed * delta, 0, abs(_theta)) * sign(_theta)
	move_and_slide()


func _is_action_on_beat() -> bool:
	return _beat_window_active


func _check_move_input() -> void:
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


func _on_beat_window_changed(active: bool) -> void:
	_beat_window_active = active


func _on_hit(dmg: float) -> void:
	print_debug("ouch i got hit")
