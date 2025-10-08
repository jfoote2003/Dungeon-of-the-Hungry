class_name Chest extends Node2D

signal toggle_inventory(external_inventory_owner)

@export var can_interact : bool = true
@export var inventory_data : InventoryData

func interact():
	toggle_inventory.emit(self)
	#play the opening animation
