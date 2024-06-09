extends Node2D
class_name Checkpoint

@export var spawn = false
@onready var active = $AudioStreamPlayer2D

var activated = false

func activate():
	Gamemanager.current_checkpoint = self
	activated = true
	active.play()


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player and !activated:
		activate()
