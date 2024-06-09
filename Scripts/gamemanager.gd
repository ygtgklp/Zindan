extends Node

var current_checkpoint : Checkpoint
var player : Player

signal game_completed

func respawn_Player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
		



