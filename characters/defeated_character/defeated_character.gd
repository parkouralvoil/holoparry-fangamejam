extends Node2D
class_name DefeatedCharacter

var texture: Texture
var sprite_scale: Vector2

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") * 2

var _initial_pos: Vector2
var _throw_direction: Vector2
var _throw_angle_degrees: float
var _initial_speed: float
var _time: float

var _z_axis: float

@onready var _sprite: Sprite2D = $SpriteCharacter

func _ready() -> void:
	var angle: float = 80
	var dist: float = CombatHelper.RNG.randf_range(80, 100)
	var direction: Vector2 = Vector2.RIGHT if CombatHelper.RNG.randf() < 0.5 else Vector2.LEFT
	_sprite.texture = texture
	_sprite.scale = sprite_scale
	_start_arc(global_position, direction, dist, angle)


func _start_arc(from_pos: Vector2,
		direction: Vector2,
		desired_distance: float,
		desired_angle_deg: float) -> void:
	
	_initial_pos = from_pos
	_throw_direction = direction.normalized()
	
	_throw_angle_degrees = desired_angle_deg
	_initial_speed = pow(desired_distance * _gravity / sin(2 * deg_to_rad(desired_angle_deg)), 0.5)
	
	global_position = from_pos
	_time = 0.0
	_z_axis = 0


func _physics_process(delta: float) -> void:
	_time += delta
	_z_axis = _initial_speed * sin(deg_to_rad(_throw_angle_degrees)) * _time \
		- (0.5 * _gravity * pow(_time, 2))
	
	var x_axis: float = _initial_speed * cos(deg_to_rad(_throw_angle_degrees)) * _time
	var new_pos: Vector2 = _initial_pos + _throw_direction * x_axis
	global_position = Vector2(new_pos.x, new_pos.y - _z_axis)
	if global_position.y > 900:
		queue_free()
