extends Node

@onready var player = %Player
@onready var inventory_interface = %InventoryInterface
@onready var hot_bar_inventory = %HotBarInventory
@onready var game_menu = %GameMenu


func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	player.party.member_added_to_party.connect(connect_to_party_members)
	inventory_interface.set_party_inventory_data(player.inventory_data)
	
	inventory_interface.set_member1_inventory_data(player.party.member1)
	
	if (player.party.member2 != null):
		inventory_interface.set_member2_inventory_data(player.party.member2)
		game_menu.enable_character2()
	else:
		game_menu.disable_character2()
	
	if (player.party.member3 != null):
		inventory_interface.set_member3_inventory_data(player.party.member3)
		game_menu.enable_character3()
	else:
		game_menu.disable_character3()
	
	if (player.party.member4 != null):
		inventory_interface.set_member4_inventory_data(player.party.member4)
		game_menu.enable_character4()
	else:
		game_menu.disable_character4()
	
	inventory_interface.force_close.connect(toggle_inventory_interface)
	inventory_interface.force_close.connect(toggle_cooking_interface)
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)
	
	for node in get_tree().get_nodes_in_group("cooking_inventory"):
		node.toggle_cooking.connect(toggle_cooking_interface)
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func toggle_inventory_interface(external_inventory_owner = null): 
	if inventory_interface.visible == false and external_inventory_owner: #if the inventory isn't open and there is an external_inv_owner
		inventory_interface.show()
		hot_bar_inventory.hide()
		inventory_interface.set_external_inventory(external_inventory_owner)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif inventory_interface.visible == false: #if inventory isn't open and there is no external_inv_owner
		inventory_interface.show()
		hot_bar_inventory.hide()
		inventory_interface.clear_external_inventory()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else: #closing the inventory
		inventory_interface.hide()
		hot_bar_inventory.show()
		inventory_interface.clear_external_inventory()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	inventory_interface.clear_cooking_inventory()

func toggle_cooking_interface(cooking_inventory_owner = null):
	if inventory_interface.visible == false and cooking_inventory_owner:
		inventory_interface.show()
		hot_bar_inventory.hide()
		inventory_interface.set_cooking_inventory(cooking_inventory_owner)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		inventory_interface.hide()
		hot_bar_inventory.show()
		inventory_interface.clear_cooking_inventory()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func open_settings(is_in_settings : bool):
	if is_in_settings:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_tree().quit()

func connect_to_party_members(member : String):
	match member:
		"member2":
			inventory_interface.set_member2_inventory_data(player.party.member2)
			game_menu.enable_character2()
		"member3":
			inventory_interface.set_member3_inventory_data(player.party.member3)
			game_menu.enable_character3()
		"member4":
			inventory_interface.set_member4_inventory_data(player.party.member4)
			game_menu.enable_character4()
