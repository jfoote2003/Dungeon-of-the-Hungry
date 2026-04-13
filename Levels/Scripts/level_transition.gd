@tool #tells godot to script run in the editor
class_name LevelTransition extends Area2D

enum SIDE {LEFT,RIGHT,TOP,BOTTOM}

signal entered_from_here

@export_file("*.tscn") var level
@export var target_transistion_area : String = "LevelTransition"

@export_category("collision area settings")

@export_range(1,12,1,"or_greater") var size : int = 2:
	set(_value): 
		size = _value
		_update_area()

@export var side : SIDE = SIDE.LEFT :
	set(_value):
		side = _value
		_update_area()

@export var snap_to_grid : bool = false :
	set(_value):
		_snap_to_grid()

@onready var collision_shape : CollisionShape2D = %CollisionShape2D


func _ready():
	_update_area()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	place_player()
	
	await GlobalLevelManager.level_loaded
	
	#await get_tree().physics_frame
	#await get_tree().physics_frame
	
	monitoring = true
	body_entered.connect(player_entered)

func _update_area():
	var new_rect : Vector2 = Vector2(16,16)
	var new_pos : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_pos.y -= 8
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_pos.y += 8
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_pos.x -= 8
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_pos.x += 8
	
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_pos

func _snap_to_grid() -> void:
	position.x = round(position.x / 8) * 8
	position.y = round(position.y / 8) * 8

func player_entered(_p : Player) -> void:
	GlobalLevelManager.load_new_level(level,target_transistion_area,get_offset())
	#print("entered")

func place_player():
	if name != GlobalLevelManager.target_transistion:
		return
	PlayerManager.set_player_position(global_position + GlobalLevelManager.position_offset)
	entered_from_here.emit()

func get_offset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos : Vector2 = PlayerManager.player.global_position
	
	match side:
		SIDE.TOP:
			offset.x = player_pos.x - global_position.x
			offset.y = -16
		SIDE.BOTTOM:
			offset.x = player_pos.x - global_position.x
			offset.y = 16
		SIDE.LEFT:
			offset.y = player_pos.y - global_position.y
			offset.x = -16
		SIDE.RIGHT:
			offset.y = player_pos.y - global_position.y
			offset.x = 16
	
	return offset
