extends Control
class_name MainMenu

@onready var _button_play_ai: TextureButton = %PlayAI
@onready var _button_play_tutorial: TextureButton = %PlayTutorial
@onready var _button_settings: TextureButton = %Settings
@onready var _button_credits: TextureButton = %Credits
@onready var _button_quit: TextureButton = %Quit
@onready var _return_button: Button = $ReturnButton

## Menus
@onready var _title_screen: Control = $TitleScreen
@onready var _character_selection_screen: Control = $CharacterSelection
@onready var _settings_screen: Control= $SettingsMenu
@onready var _credits: CenterContainer = $Credits

func _ready() -> void:
	_button_play_ai.pressed.connect(_on_button_play_ai_pressed)
	_button_play_tutorial.pressed.connect(_on_button_play_tutorial_pressed)
	_button_settings.pressed.connect(_on_button_settings_pressed)
	_button_credits.pressed.connect(_on_button_credits_pressed)
	_button_quit.pressed.connect(_on_button_quit_pressed)
	_return_button.pressed.connect(_on_button_return_pressed)
	
	_title_screen.show()
	_character_selection_screen.hide()
	_settings_screen.hide()
	_return_button.hide()
	_credits.hide()


func _on_button_play_ai_pressed() -> void:
	_title_screen.hide()
	_return_button.show()
	_character_selection_screen.show()


func _on_button_play_tutorial_pressed() -> void:
	SceneLoader.goto_tutorial()


func _on_button_settings_pressed() -> void:
	_title_screen.hide()
	_return_button.show()
	_settings_screen.show()


func _on_button_credits_pressed() -> void:
	_title_screen.hide()
	_return_button.show()
	_credits.show()


func _on_button_return_pressed() -> void: ## this hasnt been added yet
	## better to connect via editor instead of code
	## since theres a lot of return buttons
	_title_screen.show()
	_character_selection_screen.hide()
	_settings_screen.hide()
	_return_button.hide()
	_credits.hide()


func _on_button_quit_pressed() -> void:
	get_tree().quit()
