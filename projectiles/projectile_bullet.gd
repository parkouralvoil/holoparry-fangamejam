extends BaseProjectile


func _per_frame_visuals(_delta: float) -> void:
	## change this for purely visual stuff
	_Sprite.rotation = direction.angle()
