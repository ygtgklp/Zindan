extends Node2D

@onready var victory_screen = $Player/Victory_Screen

func _ready():
	Gamemanager.game_completed.connect(show_victory)


func show_victory():
	victory_screen.show()
	get_tree().paused = true


func _on_victory_screen_retry():
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)
