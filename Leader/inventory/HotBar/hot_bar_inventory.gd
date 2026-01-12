extends PanelContainer

signal hot_bar_used(index : int)

const SLOT = preload("uid://cai003s8xcg22")


@onready var h_box_container = $MarginContainer/HBoxContainer
@onready var player = $"."

var selected_index : int = 0

func set_inventory_data(inventory_data : InventoryData):
	inventory_data.inventory_updated.connect(populate_hot_bar)
	populate_hot_bar(inventory_data)
	hot_bar_used.connect(inventory_data.use_slot_data)

func populate_hot_bar(inventory_data : InventoryData):
	for child in h_box_container.get_children():
		child.queue_free()
	
	for slot_data in inventory_data.slot_datas.slice(0,9):
		var slot = SLOT.instantiate()
		h_box_container.add_child(slot)
		if slot_data:
			slot.set_slot_data(slot_data)
	
	update_selection_visuals()

func _unhandled_input(event : InputEvent):
	if not visible:
		return
	
	#mouse scroll wheel
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
			selected_index = (selected_index - 1 + 9) % 9
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			selected_index = (selected_index + 1) % 9
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		hot_bar_used.emit(selected_index)
	
	update_selection_visuals()

func update_selection_visuals():
	for i in range(h_box_container.get_child_count()):
		var slot = h_box_container.get_child(i)
		slot.set_highlighted(i == selected_index)
