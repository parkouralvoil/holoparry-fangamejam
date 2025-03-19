extends CharacterBody2D
class_name BaseCharacter

## Base character class for controllable vtubers

@export var _Moveset: BaseMoveset
@export var _Hitbox: CharacterHitbox


var _move_direction: Vector2
var _speed: float = 250.0
var _beat_window_active: bool = false
var _player_combo: Array[PT.Combo] = []:
	set(val):
		_player_combo = val
		print_debug("hello")
var _rotation_speed: float = TAU * 3 # TAU is a full circle, this is 2 full rotations per sec
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
	_check_move_input()
		
	if Input.is_action_just_pressed("beat_activate"):
		print_debug(_is_action_on_beat())
		# if _is_action_on_beat():
		## currently have this commented so i can test easier
		_perform_combo()
	
	if Input.is_action_just_pressed("combo_up"):
		_add_combo(PT.Combo.UP)
	if Input.is_action_just_pressed("combo_down"):
		_add_combo(PT.Combo.DOWN)


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
		_theta = wrapf(atan2(_move_direction.y, _move_direction.x) - _Sprite.rotation + PI/2, 
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
