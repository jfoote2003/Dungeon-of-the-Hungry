extends Control


func _ready():
	pass

func set_inventory_data(inventory_data : InventoryData):
	%PartyInventory.set_inventory_data(inventory_data)

func set_player1_inventory_data(member : PartyMember):
	%HelmetInventory1.set_inventory_data(member.helmet_inv_data)
	%OffhandInventory1.set_inventory_data(member.offhand_inv_data)
	%ChestInventory1.set_inventory_data(member.chest_inv_data)
	%MainInventory1.set_inventory_data(member.weapon_inv_data)
	%GreevesInventory1.set_inventory_data(member.greeves_inv_data)
	%Ring1Inventory1.set_inventory_data(member.ring1_inv_data)
	%BootsInventory1.set_inventory_data(member.boots_inv_data)
	%Ring2Inventory1.set_inventory_data(member.ring2_inv_data)

func set_player2_inventory_data(member : PartyMember):
	%HelmetInventory2.set_inventory_data(member.helmet_inv_data)
	%OffhandInventory2.set_inventory_data(member.offhand_inv_data)
	%ChestInventory2.set_inventory_data(member.chest_inv_data)
	%MainInventory2.set_inventory_data(member.weapon_inv_data)
	%GreevesInventory2.set_inventory_data(member.greeves_inv_data)
	%Ring1Inventory2.set_inventory_data(member.ring1_inv_data)
	%BootsInventory2.set_inventory_data(member.boots_inv_data)
	%Ring2Inventory2.set_inventory_data(member.ring2_inv_data)

func set_player3_inventory_data(member : PartyMember):
	%HelmetInventory3.set_inventory_data(member.helmet_inv_data)
	%OffhandInventory3.set_inventory_data(member.offhand_inv_data)
	%ChestInventory3.set_inventory_data(member.chest_inv_data)
	%MainInventory3.set_inventory_data(member.weapon_inv_data)
	%GreevesInventory3.set_inventory_data(member.greeves_inv_data)
	%Ring1Inventory3.set_inventory_data(member.ring1_inv_data)
	%BootsInventory3.set_inventory_data(member.boots_inv_data)
	%Ring2Inventory3.set_inventory_data(member.ring2_inv_data)

func set_player4_inventory_data(member : PartyMember):
	%HelmetInventory4.set_inventory_data(member.helmet_inv_data)
	%OffhandInventory4.set_inventory_data(member.offhand_inv_data)
	%ChestInventory4.set_inventory_data(member.chest_inv_data)
	%MainInventory4.set_inventory_data(member.weapon_inv_data)
	%GreevesInventory4.set_inventory_data(member.greeves_inv_data)
	%Ring1Inventory4.set_inventory_data(member.ring1_inv_data)
	%BootsInventory4.set_inventory_data(member.boots_inv_data)
	%Ring2Inventory4.set_inventory_data(member.ring2_inv_data)

func clear_player1_inventory_data():
	%HelmetInventory1.clear_inventory_data()
	%OffhandInventory1.clear_inventory_data()
	%ChestInventory1.clear_inventory_data()
	%MainInventory1.clear_inventory_data()
	%GreevesInventory1.clear_inventory_data()
	%Ring1Inventory1.clear_inventory_data()
	%BootsInventory1.clear_inventory_data()
	%Ring2Inventory1.clear_inventory_data()

func clear_player2_inventory_data():
	%HelmetInventory2.clear_inventory_data()
	%OffhandInventory2.clear_inventory_data()
	%ChestInventory2.clear_inventory_data()
	%MainInventory2.clear_inventory_data()
	%GreevesInventory2.clear_inventory_data()
	%Ring1Inventory2.clear_inventory_data()
	%BootsInventory2.clear_inventory_data()
	%Ring2Inventory2.clear_inventory_data()

func clear_player3_inventory_data():
	%HelmetInventory3.clear_inventory_data()
	%OffhandInventory3.clear_inventory_data()
	%ChestInventory3.clear_inventory_data()
	%MainInventory3.clear_inventory_data()
	%GreevesInventory3.clear_inventory_data()
	%Ring1Inventory3.clear_inventory_data()
	%BootsInventory3.clear_inventory_data()
	%Ring2Inventory3.clear_inventory_data()

func clear_player4_inventory_data():
	%HelmetInventory4.clear_inventory_data()
	%OffhandInventory4.clear_inventory_data()
	%ChestInventory4.clear_inventory_data()
	%MainInventory4.clear_inventory_data()
	%GreevesInventory4.clear_inventory_data()
	%Ring1Inventory4.clear_inventory_data()
	%BootsInventory4.clear_inventory_data()
	%Ring2Inventory4.clear_inventory_data()

func toggle_menu_buttons():
	%MenuButtons.visible = !%MenuButtons.visible

func _on_inventory_pressed() -> void:
	show_inventory()

func _on_equipment_pressed() -> void:
	%PartyInventory.visible = false
	%PartyStats.visible = false
	%PartyEquipment.visible = true

func _on_stats_pressed() -> void:
	%PartyInventory.visible = false
	%PartyEquipment.visible = false
	%PartyStats.visible = true

func _on_party_pressed() -> void:
	pass # Replace with function body.

func _on_quests_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()

func disable_character2():
	%Character2.visible = false
	%Character2Stats.visible = false
	print("boobs")

func disable_character3():
	%Character3.visible = false
	%Character3Stats.visible = false

func disable_character4():
	%Character4.visible = false
	%Character4Stats.visible = false

func enable_character2():
	%Character2.visible = true
	%Character2Stats.visible = true

func enable_character3():
	%Character3.visible = true
	%Character3Stats.visible = true

func enable_character4():
	%Character4.visible = true
	%Character4Stats.visible = true

func show_inventory():
	%PartyEquipment.visible = false
	%PartyStats.visible = false
	%PartyInventory.visible = true
