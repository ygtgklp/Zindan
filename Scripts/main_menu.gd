extends Control
class_name MainMenu


@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var credits = $MarginContainer/HBoxContainer/VBoxContainer/Credits as Button
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/Options as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var options_menu = $Options_Menu as OptionsMenu
@onready var credits_menu = $Credits as Credits
@onready var margin_container = $MarginContainer as MarginContainer
@onready var ninepatch = $NinePatchRect as NinePatchRect
@onready var level = preload("res://Scenes/world.tscn") as PackedScene

func _ready():
	$AudioStreamPlayer.play()
	handle_connecting_signals()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func on_start_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_packed(level)
	

func on_options_pressed() -> void:
	margin_container.visible = false
	ninepatch.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_credits_pressed() -> void:
	margin_container.visible = false
	ninepatch.visible = false
	credits_menu.set_process(true)
	credits_menu.visible = true

func on_quit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu():
	margin_container.visible = true
	ninepatch.visible = true
	options_menu.visible = false

func on_exit_credits_menu():
	margin_container.visible = true
	ninepatch.visible = true
	credits_menu.visible = false

func handle_connecting_signals() -> void:
	start.button_down.connect(on_start_pressed)
	options.button_down.connect(on_options_pressed)
	credits.button_down.connect(on_credits_pressed)
	quit.button_down.connect(on_quit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	credits_menu.exit_credits.connect(on_exit_credits_menu)
	
