extends CenterContainer
class_name SettingsMenu

## Settings stuffs
@onready var _slider_music: HSlider = %Music
@onready var _slider_sound: HSlider = %Sound
@onready var _action_list: VBoxContainer = %ActionList

func _ready() -> void:
	_slider_music.value = SettingsValues.volume['Music']
	_slider_sound.value = SettingsValues.volume['Sound']

# --- Audio

func _on_music_value_changed(value: float) -> void:
	SettingsValues.change_volume(value, 'Music')

func _on_sound_value_changed(value: float) -> void:
	SettingsValues.change_volume(value, 'Sound')

# --- Controls
