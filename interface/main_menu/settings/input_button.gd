extends Button
class_name InputButton

@export var _input_event: InputEventKey
@export var _input_control: String

@onready var _label: Label = %Label

func _input(event: InputEvent) -> void:
	# set keybind
	if self.button_pressed:
		if event is InputEventKey:
			match event.keycode:
				KEY_NONE:
					return
				KEY_ESCAPE:
					# restore previous keybind
					self.set_input_event(self._input_event)
				_:
					# set new keybind
					self.set_input_event(event)

func _toggled(toggled_on: bool) -> void:
	if toggled_on:
		self._label.set_text('Press any key...')
	else:
		self._update_label()

func _update_label() -> void:
	if self._input_event:
		self._label.set_text(OS.get_keycode_string(self._input_event.keycode))
	else:
		self._label.set_text('No key selected')

func set_input_event(event: InputEventKey):
	self._input_event = event
	SettingsValues.change_controls(event, self._input_control)
	
	self._update_label()
	self.set_pressed(false)
