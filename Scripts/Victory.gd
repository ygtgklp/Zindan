extends Area2D

@onready var audio_stream_player = $"../AudioStreamPlayer"

func _on_area_entered(area):
	if area.get_parent() is Player:
		Gamemanager.game_completed.emit()
		audio_stream_player.play()

