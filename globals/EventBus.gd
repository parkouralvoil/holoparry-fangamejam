extends Node

signal beat_window_changed(active: bool) ## for BeatManager to Player communication
signal player_combo_updated(new_combo: Array[PT.Combo]) ## Player to PlayerInterface
