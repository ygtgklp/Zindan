extends Control
class_name OptionsMenu

@onready var back = $Back as Button

signal exit_options_menu

func _ready():
	back.button_down.connect(on_back_pressed)
	set_process(false)


func on_back_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)
