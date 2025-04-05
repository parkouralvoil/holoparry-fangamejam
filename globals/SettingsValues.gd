extends Node

# --- Audio

var volume: Dictionary[String, float] =  {
	# 100/100
	'Sound': 60,
	'Music': 60
}

@onready var _bus_music_index: int = AudioServer.get_bus_index('Sound')
@onready var _bus_sound_index: int = AudioServer.get_bus_index('Music')

func _update_volumes() -> void:
	AudioServer.set_bus_volume_linear(
		self._bus_music_index, self.volume['Music'] / 100.0
	)
	AudioServer.set_bus_volume_linear(
		self._bus_sound_index, self.volume['Sound'] / 100.0
	)

func change_volume(value: float, volume_name: String) -> void:
	if volume_name not in self.volume: return
	
	# set volume of specified volume setting name (music/sound)
	self.volume[volume_name] = value
	self._update_volumes()

# --- Controls

var controls: Dictionary[String, Key] = {
	'beat_0': KEY_DOWN,
	'beat_1': KEY_UP
}
var _controls_inv: Dictionary[Key, String] = {
	KEY_DOWN: 'beat_0',
	KEY_UP: 'beat_1'
}

func change_controls(event: InputEvent, control_name: String) -> void:
	# ignore if event is not a key input
	if event is not InputEventKey: 
		return
	var key = event.keycode
	
	# ignore if control name does not exist
	if control_name not in self.controls: 
		return
	
	# ---
	
	# unbind old key if currently mapped
	if key in self._controls_inv:
		var old_key: Key = self.controls[self._controls_inv[key]]
		var old_control: String = self._controls_inv[self.controls[control_name]]
		self.controls[old_control] = KEY_NONE
		self._controls_inv.erase(old_key)
	
	# bind new key
	self.controls[control_name] = key
	self._controls_inv[key] = control_name
	
	# change input map
	match control_name:
		'beat_0':
			InputMap.action_erase_events('combo_down')
			InputMap.action_add_event('combo_down', event)
		'beat_1':
			InputMap.action_erase_events('combo_up')
			InputMap.action_add_event('combo_up', event)
		'_':
			return
