extends TextureRect
class_name ComboArrow


func change_arrow(combo: PT.Combo) -> void:
	if combo == PT.Combo.DOWN:
		flip_v = true
		modulate = Color.PURPLE
	else:
		flip_v = false
		modulate = Color.SKY_BLUE
