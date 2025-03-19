extends Area2D
class_name BaseHitbox

signal got_hit(damage: float)

func take_damage(dmg: float) -> void:
	## called by projectiles that detect this hitbox
	got_hit.emit(dmg)
