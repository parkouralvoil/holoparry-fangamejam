extends CharacterBody2D
class_name BaseEnemy

var _DefeatedPackedScene: PackedScene = preload(
		"res://characters/defeated_character/defeated_character.tscn"
	)

## Base character class for AI vtubers

@export var _Moveset: BaseMoveset
@export var _Hitbox: BaseHitbox
@export var _EnemyParryBehavior: Area2D
@export var _move_timer_duration: float
@export var _parry_timer_duration: float

@export_category("Character Specific")
@export var _audio_death_scream: AudioStream
@export var _audio_parry: AudioStream

@export_category("Sprite Textures")
@export var _texture_idle: Texture
@export var _texture_move: Texture
@export var _texture_hurt: Texture

var _character_resource_state: CharacterInfoState

var _move_direction: Vector2
var _face_direction: Vector2 = _move_direction
var _speed: float = 100.0

var _attack_counter: int = 0
var _attack_threshold: int = 4

@onready var _SpriteCharacter: Sprite2D = $SpriteCharacter
@onready var _MoveTimer: Timer = $MoveTimer
@onready var _ParryTimer: Timer = $ParryTimer
@onready var _RNG: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var _t_hurt_duration: Timer = $HurtDuration


func initialize_resource_state(state: CharacterInfoState) -> void:
	## called by round manager
	_character_resource_state = state


func _ready() -> void:
	# this gets called at the start of the scene
	assert(_Moveset)
	assert(_Hitbox)
	_Moveset.assign_resource_state(_character_resource_state)
	_Moveset.audio_parry = _audio_parry
	EventBus.beat_update.connect(_on_beat_update)
	_Hitbox.got_hit.connect(_on_hit)
	_MoveTimer.start(_move_timer_duration)
	_MoveTimer.timeout.connect(_on_move_timer_timeout)
	_character_resource_state.initialize_hp()


func _process(_delta: float) -> void:
	CombatHelper.enemy_global_position = global_position


func _physics_process(_delta: float) -> void:
	velocity = _move_direction.normalized() * _speed
	if _move_direction != Vector2.ZERO:
		_face_direction = _move_direction
	_change_anim()
	move_and_slide()


func _on_beat_update() -> void:
	if _EnemyParryBehavior.has_overlapping_areas() and _ParryTimer.is_stopped():
		_ParryTimer.start(_parry_timer_duration)
		_Moveset.enemy_use_skill(0)
		_attack_counter = _attack_threshold
		return
	if _attack_counter >= _attack_threshold:
		var num := CombatHelper.RNG.randf()
		if num < 0.2:
			_Moveset.enemy_use_skill(3)
			_attack_counter = 1
		elif num < 0.5:
			_Moveset.enemy_use_skill(2)
			_attack_counter = 2
		else:
			_Moveset.enemy_use_skill(1)
			_attack_counter = 2
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


func _on_hit(dmg: int) -> void:
	_character_resource_state.take_damage(dmg)
	_t_hurt_duration.start()


func _change_anim() -> void:
	if not _t_hurt_duration.is_stopped():
		_SpriteCharacter.texture = _texture_hurt
	elif _move_direction != Vector2.ZERO:
		_SpriteCharacter.texture = _texture_move
	else:
		_SpriteCharacter.texture = _texture_idle
	
	if _move_direction.x > 0.1:
		_SpriteCharacter.flip_h = false
	elif _move_direction.x < -0.1:
		_SpriteCharacter.flip_h = true


func defeated() -> void:
	var defeated_sprite: DefeatedCharacter = _DefeatedPackedScene.instantiate()
	defeated_sprite.global_position = _SpriteCharacter.global_position
	defeated_sprite.texture = _texture_hurt
	defeated_sprite.sprite_scale = _SpriteCharacter.scale
	SoundPlayer.play_sound(_audio_death_scream)
	add_sibling(defeated_sprite)
	await get_tree().process_frame
	queue_free()
