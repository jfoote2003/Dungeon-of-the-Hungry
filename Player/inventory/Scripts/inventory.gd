extends PanelContainer


const SLOT = preload("uid://cai003s8xcg22")
@onready var item_grid = %ItemGrid

func set_inventory_data(inventory_data : InventoryData):
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func clear_inventory_data(inventory_data : InventoryData):
	inventory_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(inventory_data : InventoryData):
	for child in item_grid.get_children():
		child.queue_free() #deletes each of the children in the itemgrid
	
	for slot_data in inventory_data.slot_datas:
		var slot = SLOT.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
