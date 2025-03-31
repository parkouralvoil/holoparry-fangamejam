extends Resource
class_name ResourceCharacterData

"""
this stores the 
- vtuber portrait
- vtuber name
- character scene (when playing as player) 
- enemy scene (when picked for AI)

used to 
"""

@export var vtuber_name: String
@export var character_scene: PackedScene
@export var enemy_scene: PackedScene
