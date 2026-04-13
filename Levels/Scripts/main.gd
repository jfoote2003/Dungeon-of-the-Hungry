class_name Main extends Node2D

var player : Player
@onready var inventory_interface = %InventoryInterface
@onready var game_menu = %GameMenu


func _ready():
	self.y_sort_enabled = true
	
	child_entered_tree.connect(player_initialize)
	
	PlayerManager.set_as_parent(self)
	GlobalLevelManager.level_load_started.connect(free_level)
	
	for node in get_children():
		if node is CookingFire:
			%CookingButton.pressed.connect(node.cooking)


func player_initialize(input_node : Node) -> void:
	if input_node is Player:
		player = input_node
		
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
		
		for node in get_tree().get_nodes_in_group("external_inventory"):
			node.toggle_inventory.connect(toggle_inventory_interface)
		
		for node in get_tree().get_nodes_in_group("cooking_inventory"):
			node.toggle_cooking.connect(toggle_cooking_interface)
		
		
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func toggle_inventory_interface(external_inventory_owner = null): 
	if inventory_interface.visible == false and external_inventory_owner: #if the inventory isn't open and there is an external_inv_owner
		inventory_interface.show()
		inventory_interface.set_external_inventory(external_inventory_owner)
		
		game_menu.hide_equipment()
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif inventory_interface.visible == false: #if inventory isn't open and there is no external_inv_owner
		inventory_interface.show()
		inventory_interface.clear_external_inventory()
		
		game_menu.show_equipment()
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else: #closing the inventory
		inventory_interface.hide()
		inventory_interface.clear_external_inventory()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	inventory_interface.clear_cooking_inventory()

func toggle_cooking_interface(cooking_inventory_owner = null):
	if inventory_interface.visible == false and cooking_inventory_owner:
		inventory_interface.show()
		inventory_interface.set_cooking_inventory(cooking_inventory_owner)
		
		game_menu.hide_equipment()
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		inventory_interface.hide()
		inventory_interface.clear_cooking_inventory()
		
		game_menu.show_equipment()
		
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

func free_level():
	PlayerManager.unparent_player(self)
	queue_free()
