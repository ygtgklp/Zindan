extends Control
class_name PauseMenu

@onready var paused_options_menu = $Paused_Options_Menu as PausedOptionsMenu
@onready var victory_screen = $"../Victory_Screen"

var _is_paused:bool = false:
	set = set_paused

func _ready():
	handle_connecting_signals()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !victory_screen.visible:
		_is_paused = !_is_paused


func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused



func _on_resume_button_pressed():
	_is_paused = false



func _on_options_button_pressed():
	$NinePatchRect.visible = false
	$Label.visible = false
	$ResumeButton.visible = false
	$OptionsButton.visible = false
	$QuitButton.visible = false
	paused_options_menu.set_process(true)
	paused_options_menu.visible = true

func on_exit_Poptions_menu():
	$NinePatchRect.visible = true
	$Label.visible = true
	$ResumeButton.visible = true
	$OptionsButton.visible = true
	$QuitButton.visible = true
	paused_options_menu.visible = false


func _on_quit_button_pressed():
	get_tree().quit()

func handle_connecting_signals() -> void:
	$ResumeButton.button_down.connect(_on_resume_button_pressed)
	$OptionsButton.button_down.connect(_on_options_button_pressed)
	$QuitButton.button_down.connect(_on_quit_button_pressed)
	paused_options_menu.exit_Poptions_menu.connect(on_exit_Poptions_menu)
	
