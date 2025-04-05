extends Node

# --- Audio

var _volume =  {
	# 100/100
	'music': 60,
	'sound': 60
}

@onready var _bus_music_index = AudioServer.get_bus_index('music')
@onready var _bus_sound_index = AudioServer.get_bus_index('sound')

func _update_volumes():
	AudioServer.set_bus_volume_linear(
		self._bus_music_index, self._volume['music'] / 100.0
	)
	AudioServer.set_bus_volume_linear(
		self._bus_sound_index, self._volume['sound'] / 100.0
	)

func change_volume(value: int, volume_name: String):
	if volume_name not in self._volume: return
	
	# set volume of specified volume setting name (music/sound)
	self._volume[volume_name] = value
	self._update_volumes()

# --- Controls

var _controls = {
	'beat_0': KEY_DOWN,
	'beat_1': KEY_UP
}
var _controls_inv = {
	KEY_DOWN: 'beat_0',
	KEY_UP: 'beat_1'
}

func change_controls(event: InputEvent, control_name: String):
	# ignore if event is not a key input
	if event is not InputEventKey: return
	var key = event.keycode
	
	# ignore if control name does not exist
	if control_name not in self._controls: return
	
	# ---
	
	# unbind old key if currently mapped
	if key in self._controls_inv:
		var old_key: Key = self._controls[self._controls_inv[key]]
		var old_control: String = self._controls_inv[self._controls[control_name]]
		self._controls[old_control] = KEY_NONE
		self._controls_inv.erase(old_key)
	
	# bind new key
	self._controls[control_name] = key
	self._controls_inv[key] = control_name
	
	# change input map
	match control_name:
		'beat_0':
			InputMap.action_add_event('combo_down', event)
		'beat_1':
			InputMap.action_add_event('combo_up', event)
		'_':
			return
