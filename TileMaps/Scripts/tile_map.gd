class_name MyTileSet extends Node

@onready var ground: TileMapLayer = %ground


func _ready() -> void:
	GlobalLevelManager.change_tilemap_bounds(get_tilemap_bounds())
	pass

func get_tilemap_bounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	
	bounds.append(
		Vector2(ground.get_used_rect().position * ground.rendering_quadrant_size) #top left
	)
	bounds.append(
		Vector2(ground.get_used_rect().end * ground.rendering_quadrant_size) #bottom right
	)
	
	return bounds
