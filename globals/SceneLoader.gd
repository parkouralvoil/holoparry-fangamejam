extends Node

## https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html#custom-scene-switcher

var current_scene = null

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)


func goto_ai_level():
	_goto_scene("res://levels/ai_level/ai_level.tscn")


func goto_main_menu():
	_goto_scene("res://interface/main_menu/main_menu.tscn")


func goto_tutorial():
	_goto_scene("res://levels/tutorial_level/tutorial_level.tscn")


func _goto_scene(path):
	_deferred_goto_scene.call_deferred(path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
