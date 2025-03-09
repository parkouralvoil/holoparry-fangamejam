extends Area2D
class_name CharacterHitbox

signal got_hit(damage: float)


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	print_debug("hitbox hit")
	## check if area is projectile and has damage
	var test_value := 10.0 ## HACK, this will be changed
	got_hit.emit(test_value)
