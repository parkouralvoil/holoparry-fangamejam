extends Control
class_name MainMenu

@onready var _button_play_ai: TextureButton = %PlayAI
@onready var _button_play_tutorial: TextureButton = %PlayTutorial
@onready var _button_settings: TextureButton = %Settings
@onready var _button_quit: TextureButton = %Quit
@onready var _return_button: Button = $ReturnButton

## Menus
@onready var _title_screen := $TitleScreen
@onready var _character_selection_screen := $CharacterSelection
@onready var _settings_screen := $SettingsMenu

func _ready() -> void:
	_button_play_ai.pressed.connect(_on_button_play_ai_pressed)
	_button_play_tutorial.pressed.connect(_on_button_play_tutorial_pressed)
	_button_settings.pressed.connect(_on_button_settings_pressed)
	_button_quit.pressed.connect(_on_button_quit_pressed)
	_return_button.pressed.connect(_on_button_return_pressed)
	
	_title_screen.show()
	_character_selection_screen.hide()
	_settings_screen.hide()
	_return_button.hide()


func _on_button_play_ai_pressed() -> void:
	_title_screen.hide()
	_return_button.show()
	_character_selection_screen.show()

func _on_button_play_tutorial_pressed() -> void:
	print_debug("start tutorial")
	## change scene to Tutorial level

func _on_button_settings_pressed() -> void:
	_title_screen.hide()
	_return_button.show()
	_settings_screen.show()


func _on_button_return_pressed() -> void: ## this hasnt been added yet
	## better to connect via editor instead of code
	## since theres a lot of return buttons
	_title_screen.show()
	_character_selection_screen.hide()
	_settings_screen.hide()
	_return_button.hide()


func _on_button_quit_pressed() -> void:
	get_tree().quit()
