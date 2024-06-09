extends Control
class_name PausedOptionsMenu

@onready var back = $Back as Button

signal exit_Poptions_menu

func _ready():
	back.button_down.connect(on_back_pressed)
	set_process(false)


func on_back_pressed() -> void:
	exit_Poptions_menu.emit()
	set_process(false)
