class_name CookingFire extends Node2D

signal toggle_cooking(cooking_inventory_owner)

#all recipes
const MUSHROOM_SOUP_R = preload("uid://bh8dsom6v8cwd")

var all_recipes = [MUSHROOM_SOUP_R]

@export var inventory_input : InventoryData
@export var inventory_output : InventoryData
@export var button : Button
@export var can_interact : bool = true

func _ready() -> void:
	$Sprite2D.play("default",1,false)
	button.pressed.connect(cooking)
	$AudioStreamPlayer2D.playing = true

func interact():
	toggle_cooking.emit(self)

func cooking():
	var available_ingredients = []
	
	#gets items in slot then outputs it to available_ingedients
	for slot in inventory_input.slot_datas:
		if slot and slot.item_data:
			slot.quantity -= 1
			if slot.quantity <= 0:
				inventory_input.slot_datas[inventory_input.slot_datas.find(slot)] = null
			inventory_input.inventory_updated.emit(inventory_input)
			var slot_data = slot.item_data
			available_ingredients.append(slot_data)
	
	var found_recipe : bool = false
	var cooked_item
	var output_slot = inventory_output.slot_datas[0]
	
	for i in range(all_recipes.size()):
		if found_recipe == false:
			cooked_item = all_recipes[i].compare(available_ingredients)
			if cooked_item != null:
				#print(cooked_item.name)
				found_recipe = true
	
	if available_ingredients != [] and found_recipe:
		if output_slot == null and cooked_item != null: #nothing in slot
			var output_item = SlotData.new()
			output_item.item_data = cooked_item
			output_item.quantity = 1
			inventory_output.slot_datas[0] = output_item
		elif output_slot.item_data == cooked_item: #item in slot is same as cooked item
			output_slot.quantity += 1
		else: #item in slot doesn't match cooked item
			pass
			#print("no bitches")
		inventory_output.inventory_updated.emit(inventory_output)
