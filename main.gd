extends Node

@onready var player = %Player
@onready var inventory_interface = %InventoryInterface
@onready var hot_bar_inventory = %HotBarInventory
@onready var stat_menu: Control = %StatMenu


func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
	inventory_interface.force_close.connect(toggle_inventory_interface)
	inventory_interface.force_close.connect(toggle_cooking_interface)
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	
	stat_menu.stat_changed.connect(update_player_stats)
	player.player_level_up.connect(increase_stat_points)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)
	
	for node in get_tree().get_nodes_in_group("cooking_inventory"):
		node.toggle_cooking.connect(toggle_cooking_interface)
	
	get_player_stats()

func toggle_inventory_interface(external_inventory_owner = null):
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
	
	if external_inventory_owner:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()

func toggle_cooking_interface(cooking_inventory_owner = null):
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
	
	if cooking_inventory_owner:
		inventory_interface.set_cooking_inventory(cooking_inventory_owner)
	else:
		inventory_interface.clear_cooking_inventory()
		cooking_inventory_owner = null

func update_player_stats(stat_array : Array):
	#print(stat_array)
	player.rpg_class.increase_stats(stat_array)

func increase_stat_points():
	%StatMenu.stat_points += 1
	%StatMenu.update_stat_points()

func get_player_stats():
	%StatMenu.player_strength = player.rpg_class.strength
	%StatMenu.player_agility = player.rpg_class.agility
	%StatMenu.player_endurance = player.rpg_class.endurance
	%StatMenu.player_intelligence = player.rpg_class.intelligence
	%StatMenu.player_devotion = player.rpg_class.devotion
	%StatMenu.player_luck = player.rpg_class.luck
	%StatMenu.player_cooking = player.rpg_class.cooking
