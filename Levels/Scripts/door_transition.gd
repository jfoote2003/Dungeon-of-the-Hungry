@tool
class_name DoorTransition extends Node2D

@export_file("*.tscn") var level
@export var target_transistion_area : String = "LevelTransition"

@export var snap_to_grid : bool = false :
	set(_value):
		_snap_to_grid()

func _ready():
	_snap_to_grid()
	

func interact():
	GlobalLevelManager.load_new_level(level,target_transistion_area,get_offset())
	#print("interact with door")

func _snap_to_grid() -> void:
	position.x = round(position.x / 8) * 8
	position.y = round(position.y / 8) * 8

func get_offset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos : Vector2 = PlayerManager.player.global_position
	
	offset.x = player_pos.x - global_position.x
	offset.y = -16
	
	return offset
