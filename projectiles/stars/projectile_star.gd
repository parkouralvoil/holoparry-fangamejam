extends BaseProjectile


func _per_frame_visuals(delta: float) -> void:
	## make the star spin!
	_Sprite.rotation += PI * delta
