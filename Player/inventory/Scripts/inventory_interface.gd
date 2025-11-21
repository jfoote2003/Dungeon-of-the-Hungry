extends Control

signal force_close

@onready var player_inventory = %PlayerInventory
@onready var grabbed_slot = %GrabbedSlot
@onready var external_inventory = %ExternalInventory

@onready var player_equipment_inventory: VBoxContainer = %PlayerEquipmentInventory


@onready var cooking_ui: VBoxContainer = %CookingUI
@onready var cooking_inventory_input: PanelContainer = %CookingInventoryInput
@onready var cooking_inventory_output: PanelContainer = %CookingInventoryOutput
@onready var cooking_button: Button = %CookingButton



var grabbed_slot_data : SlotData
var external_inventory_owner
var cooking_inventory_owner

func set_player_inventory_data(inventory_data : InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)

func on_inventory_interact(inventory_data : InventoryData, index : int, button : int):
	match [grabbed_slot_data, button]: #similar to a swith but with arrays rather than a single variable
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data(index)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
	
	update_grabbed_slot()

func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()

func _physics_process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5,5)
	
	if external_inventory_owner \
			and external_inventory_owner.global_position.distance_to(PlayerManager.get_global_position()) > 50:
				force_close.emit()
	if cooking_inventory_owner \
			and cooking_inventory_owner.global_position.distance_to(PlayerManager.get_global_position()) > 15:
				force_close.emit()

func set_external_inventory(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory.set_inventory_data(inventory_data)
	external_inventory.show()

func clear_external_inventory():
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory.clear_inventory_data(inventory_data)
		
		external_inventory.hide()
		external_inventory_owner = null

func set_cooking_inventory(_cooking_inventory_owner):
	cooking_inventory_owner = _cooking_inventory_owner
	var inventory_data_input = cooking_inventory_owner.inventory_input
	var inventory_data_output = cooking_inventory_owner.inventory_output
	
	inventory_data_input.inventory_interact.connect(on_inventory_interact)
	inventory_data_output.inventory_interact.connect(on_inventory_interact)
	
	cooking_inventory_input.set_inventory_data(inventory_data_input)
	cooking_inventory_output.set_inventory_data(inventory_data_output)
	
	cooking_ui.show()

func clear_cooking_inventory():
	if cooking_inventory_owner:
		var inventory_data_input = cooking_inventory_owner.inventory_input
		var inventory_data_output = cooking_inventory_owner.inventory_output
		
		inventory_data_input.inventory_interact.disconnect(on_inventory_interact)
		inventory_data_output.inventory_interact.disconnect(on_inventory_interact)
		
		cooking_inventory_input.clear_inventory_data(inventory_data_input)
		cooking_inventory_output.clear_inventory_data(inventory_data_output)
		
		cooking_ui.hide()
		cooking_inventory_owner = null
