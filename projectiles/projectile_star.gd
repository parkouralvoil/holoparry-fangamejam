extends BaseProjectile


func _process(delta: float) -> void:
	## make the star spin!
	_Sprite.rotation += PI * delta
