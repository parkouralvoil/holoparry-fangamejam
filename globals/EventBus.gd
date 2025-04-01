extends Node

signal beat_update() # for nodes that just want to know if a beat occured
signal measure_update(position: int) # unused but might be useful
signal player_combo_updated(new_combo: Array[PT.Combo]) ## Player to PlayerInterface
signal combo_or_skill_pressed(beat_quality: PT.BeatQuality) ## Moveset to BeatVisualizer
