class_name PartyMember extends Resource #battler 
 
signal hp_changed(new_hp : int, max_hp : int)
signal hunger_changer(new_hunger : int, max_hunger : int)
signal died
signal turn_ready
signal effect_applied(effect : Effect)
signal effect_removed(effect : Effect)
signal effect_tick(effect : Effect, damage : int)

@export var member_name : String
@export var rpg_class : RPGClass

@export var combat_sprite_sheet : Texture2D

@export var helmet_inv_data : InventoryDataHelmet
@export var chest_inv_data : InventoryDataChestplate
@export var greeves_inv_data : InventoryDataGreeves
@export var boots_inv_data : InventoryDataBoots
@export var ring1_inv_data : InventoryDataRing
@export var ring2_inv_data : InventoryDataRing
@export var offhand_inv_data : InventoryDataOffhand
@export var weapon_inv_data : InventoryDataWeapon

var equipment_effect : Effect

var atb_gauge : float = 0.0
var is_alive : bool = true
var is_player : bool = false

var abilities : Array[Ability] = []

func _ready():
	if rpg_class:
		apply_initial_stats()

func _process(delta):
	if is_alive and atb_gauge <= 100.0:
		pass



func apply_initial_stats():
	rpg_class.health = rpg_class.max_health
	rpg_class.hunger = rpg_class.max_hunger
	atb_gauge = randf_range(0,rpg_class.agility)

func get_hunger() -> int:
	return rpg_class.hunger

func get_speed() -> int:
	var output : int
	
	return output

func get_equipment_effects() -> Effect: #executed at the beginning of combat
	var equipment_array : Array = []
	
	var output : Effect
	
	return output

func get_effect(input_equipment : InventoryData) -> Effect:
	var output : Effect = Effect.new()
	return output
