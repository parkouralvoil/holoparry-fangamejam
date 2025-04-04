extends Timer
class_name FreezeFrame


func freeze_frame(duration: float) -> void:
	print_debug("frame frozen for ", duration)
	var tree: SceneTree = get_tree()
	start(duration)
	tree.paused = true
	await timeout
	tree.paused = false
