extends BaseSkill
class_name SkillParry

signal parry_fever_increase()

@onready var _ParryCircle: ParryCircle = $ParryCircle
@onready var _ParryAttackRemover: ParryAttackRemover = $ParryAttackRemover

func _ready() -> void:
	_ParryCircle.successful_parry.connect(_on_successful_parry)
	_ParryAttackRemover.hide()
	_ParryAttackRemover.top_level = true
	super()


func set_skill_collisions(from_enemy: bool) -> void:
	super(from_enemy)
	_ParryCircle.set_parry_check(from_enemy)
	_ParryAttackRemover.set_parry_remover(from_enemy)


func activate_skill(_fever_mode: bool) -> void:
	_ParryCircle.activate_parry_check()


func _on_successful_parry() -> void:
	parry_fever_increase.emit()
	_ParryAttackRemover.prepare_attack_remover(self.global_position)
	await get_tree().physics_frame ## this is important to give enough time
	await get_tree().physics_frame ## for the area2D to get all the overlapping projectiles
	_ParryAttackRemover.activate()
