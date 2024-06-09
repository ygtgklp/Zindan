extends Control

@onready var restart = $Restart
@onready var finish = $Finish

signal retry()


func _on_restart_pressed():
	retry.emit()



func _on_finish_pressed():
	get_tree().quit()

