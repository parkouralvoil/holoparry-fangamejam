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

## for moveset
@export var portrait: Texture
@export_multiline var skill_names: String
@export_multiline var skill_desc: String
