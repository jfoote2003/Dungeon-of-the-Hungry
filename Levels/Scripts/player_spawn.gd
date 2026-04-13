extends Node2D

func _ready() -> void:
	await get_tree().process_frame
	visible = false
	if PlayerManager.player_spawned == false:
		PlayerManager.set_player_position(global_position)
		PlayerManager.player_spawned = true
	
	
