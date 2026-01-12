extends Control

signal force_close

#@onready var player_inventory = %PlayerInventory
@onready var game_menu: Control = %GameMenu

@onready var grabbed_slot = %GrabbedSlot
@onready var external_inventory = %ExternalInventory

@onready var cooking_ui: VBoxContainer = %CookingUI
@onready var cooking_inventory_input: PanelContainer = %CookingInventoryInput
@onready var cooking_inventory_output: PanelContainer = %CookingInventoryOutput
@onready var cooking_button: Button = %CookingButton

var grabbed_slot_data : SlotData
var external_inventory_owner
var cooking_inventory_owner

func set_party_inventory_data(inventory_data : InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	game_menu.set_inventory_data(inventory_data)

func set_member1_inventory_data(member : PartyMember):
	connect_to_equipment_slots(member)
	#the physical slot
	game_menu.set_player1_inventory_data(member)

func set_member2_inventory_data(member : PartyMember):
	connect_to_equipment_slots(member)
	#the physical slot
	game_menu.set_player2_inventory_data(member)

func set_member3_inventory_data(member : PartyMember):
	connect_to_equipment_slots(member)
	#the physical slot
	game_menu.set_player3_inventory_data(member)

func set_member4_inventory_data(member : PartyMember):
	connect_to_equipment_slots(member)
	#the physical slot
	game_menu.set_player4_inventory_data(member)

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
	game_menu.toggle_menu_buttons()

func clear_external_inventory():
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory.clear_inventory_data(inventory_data)
		
		external_inventory.hide()
		external_inventory_owner = null
		game_menu.toggle_menu_buttons()

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

func connect_to_equipment_slots(member : PartyMember):
	member.helmet_inv_data.inventory_interact.connect(on_inventory_interact)
	member.chest_inv_data.inventory_interact.connect(on_inventory_interact)
	member.greeves_inv_data.inventory_interact.connect(on_inventory_interact)
	member.boots_inv_data.inventory_interact.connect(on_inventory_interact)
	member.rings_inv_data.inventory_interact.connect(on_inventory_interact)
	member.offhand_inv_data.inventory_interact.connect(on_inventory_interact)
	member.weapon_inv_data.inventory_interact.connect(on_inventory_interact)
