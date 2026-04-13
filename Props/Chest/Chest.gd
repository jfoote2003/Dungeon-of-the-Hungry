class_name Chest extends Node2D

signal toggle_inventory(external_inventory_owner)

var grid_size : int = 16

@export var can_interact : bool = true
@export var inventory_data : InventoryData

func _ready() -> void:
	snap_to_grid()

func interact():
	toggle_inventory.emit(self)
	#play the opening animation

func snap_to_grid() -> void:
	var pos : Vector2i = self.position
	pos.x = pos.x - (pos.x % grid_size)
	pos.y = pos.y - (pos.y % grid_size)
	self.position = pos
