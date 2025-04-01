extends Node2D
class_name AttackSpawner

@export var _SpawnerBox: AttackSpawnerBox
@export var _SpawnerSprite: Sprite2D

@export_category("Attack to spawn")
@export var _AttackScene: PackedScene

var damage: float ## set by skill

var from_enemy: bool = false
var parryable: bool = false

var _beat_counter: int = 0
var _beat_threshold: int = 3 ## spawn attack at 2nd beat

func _ready() -> void:
	if from_enemy:
		if parryable:
			_SpawnerSprite.modulate = Color.YELLOW
		else:
			_SpawnerSprite.modulate = Color.ORANGE_RED
	else:
		if parryable:
			_SpawnerSprite.modulate = Color.VIOLET
		else:
			_SpawnerSprite.modulate = Color.SKY_BLUE
	_SpawnerBox.set_parry_remover_collisions(from_enemy)
	EventBus.beat_update.connect(_on_beat_update)


func _on_beat_update() -> void:
	var t := create_tween()
	t.tween_property(_SpawnerSprite, "scale", Vector2(0.75, 0.75), 0.1).from(Vector2(1, 1))
	_beat_counter += 1
	if _beat_counter >= _beat_threshold:
		await get_tree().create_timer(0.2).timeout
		_spawn(_AttackScene,
		self.global_position)
		queue_free()

func _spawn(attack_packed: PackedScene, 
		origin: Vector2) -> void:
	var p: BaseExplosion = attack_packed.instantiate()
	p.global_position = origin
	p.from_enemy = from_enemy
	p.damage = damage
	p.parryable = parryable
	p.top_level = true
	add_sibling(p)
