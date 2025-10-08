extends Node

@onready var player = %Player
@onready var inventory_interface = %InventoryInterface
#@onready var external_inventory = %ExternalInventory
@onready var hot_bar_inventory = %HotBarInventory
#@onready var cooking_ui: VBoxContainer = %CookingUI



func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
	inventory_interface.force_close.connect(toggle_inventory_interface)
	inventory_interface.force_close.connect(toggle_cooking_interface)
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)
	
	for node in get_tree().get_nodes_in_group("cooking_inventory"):
		node.toggle_cooking.connect(toggle_cooking_interface)

func toggle_inventory_interface(external_inventory_owner = null):
	#inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible == false:
		inventory_interface.show()
	else:
		inventory_interface.hide()
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		hot_bar_inventory.hide()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		hot_bar_inventory.show()
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
		#print("set")
	else:
		inventory_interface.clear_external_inventory()
		#print("clear")

func toggle_cooking_interface(cooking_inventory_owner = null):
	if inventory_interface.visible == false:
		inventory_interface.show()
	else:
		inventory_interface.hide()
	
	print("visible: ",inventory_interface.visible)
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		hot_bar_inventory.hide()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		hot_bar_inventory.show()
	
	if cooking_inventory_owner and inventory_interface.visible:
		inventory_interface.set_cooking_inventory(cooking_inventory_owner)
	else:
		inventory_interface.clear_cooking_inventory()
