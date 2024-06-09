extends Control
class_name Credits

@onready var back = $Back as Button

signal exit_credits

func _ready():
	back.button_down.connect(on_back_pressed)
	set_process(false)

func on_back_pressed() -> void:
	exit_credits.emit()
	set_process(false)
	
