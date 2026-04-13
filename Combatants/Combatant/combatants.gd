class_name Combatant extends Resource

signal died(combatant : Combatant)

@export var combatant_name : String = "default"
@export var rpg_class : RPGClass = null

#@export var combat_sprite_sheet : Texture2D

@export var helmet_inv_data : InventoryDataHelmet
@export var chest_inv_data : InventoryDataChestplate
@export var greeves_inv_data : InventoryDataGreeves
@export var boots_inv_data : InventoryDataBoots
@export var ring1_inv_data : InventoryDataRing
@export var ring2_inv_data : InventoryDataRing
@export var offhand_inv_data : InventoryDataOffhand
@export var weapon_inv_data : InventoryDataWeapon

enum CombatantState {
	idle, 		#atb gauge filling 0
	ready,		#atb gauge full, awaiting input 1
	acting,		#preforming action 2
	casting,	#using ability 3
	stunned,	#can't act temp 4
	dead		#can't act 5
}

var equipment_effect : Effect

var status_effects : Array[Effect]

var atb_gauge : float = 0.0 #0.0 - 100.0
const MAX_ATB : float = 100.0
@export var is_ally : bool = false

var current_state : CombatantState = CombatantState.idle

var prepped_abilities : Array[Ability] = []
var all_abilities  : Array[Ability] = []
var max_abilities : int = 1

const FIST = preload("uid://cb7htn8hlmxdj")
const HUNGRY_DEBUFF = preload("uid://b5jag8re8rern")


func _ready():
	max_abilities = rpg_class.get_current_level()
	if rpg_class:
		apply_initial_stats()

func _process(_delta):
	if is_alive and atb_gauge <= 100.0:
		pass

func apply_initial_stats(): #function ran at the start of battle
	rpg_class.set_health(rpg_class.get_max_health())
	rpg_class.set_hunger(rpg_class.get_max_hunger())
	atb_gauge = randf_range(0,rpg_class.agility)

func get_hunger() -> int:
	return rpg_class.get_hunger()

func set_hunger(new_hunger : int):
	rpg_class.set_hunger(new_hunger)

func get_max_hunger() -> int:
	return rpg_class.get_max_hunger()

func get_health() -> int:
	return rpg_class.get_health()

func set_health(new_health : int):
	rpg_class.set_health(new_health)

func get_max_health() -> int:
	return rpg_class.get_max_health()

func get_speed() -> float:
	return rpg_class.speed

func set_speed(value : float):
	rpg_class.speed = value

func reset_speed():
	rpg_class.reset_speed()

func increase_speed(new_speed : float):
	rpg_class.speed = new_speed + (rpg_class.agility / 10.0)

func get_equipment_effects() -> Effect: #executed at the beginning of combat for each combatant
	var equipment_array : Array = []
	var output : Effect = Effect.new()
	
	equipment_array.append(helmet_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(chest_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(greeves_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(boots_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(ring1_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(ring2_inv_data.slot_datas[0].item_data.get_effect())
	
	output.combine(equipment_array)
	
	return output

func get_weapon_effect() -> Effect: #called when combatant attacks with primary/basic attack
	var weapon_effect : Effect
	var dmg_scale_stat
	if weapon_equipped():
		weapon_effect = weapon_inv_data.slot_datas[0].item_data.get_effect()
		dmg_scale_stat = weapon_inv_data.slot_datas[0].item_data.get_primary_dmg_scale()
	else: #no weapon equipped
		weapon_effect = FIST
		dmg_scale_stat = ItemDataWeapon.stat.strength
	
	#apply dmg scaling with primary stat
	match dmg_scale_stat: #most likely agility or strength
		ItemDataWeapon.stat.strength:
			weapon_effect.set_weapon_dmg(rpg_class.strength)
		ItemDataWeapon.stat.agility:
			weapon_effect.set_weapon_dmg(rpg_class.agility)
		ItemDataWeapon.stat.endurance:
			weapon_effect.set_weapon_dmg(rpg_class.endurance)
		ItemDataWeapon.stat.devotion:
			weapon_effect.set_weapon_dmg(rpg_class.devotion)
		ItemDataWeapon.stat.intelligence:
			weapon_effect.set_weapon_dmg(rpg_class.intelligence)
		ItemDataWeapon.stat.cooking:
			weapon_effect.set_weapon_dmg(rpg_class.cooking)
		ItemDataWeapon.stat.luck:
			weapon_effect.set_weapon_dmg(rpg_class.luck)
	
	return weapon_effect

func get_stats() -> Array:
	return rpg_class.get_stats()

func weapon_equipped() -> bool:
	if weapon_inv_data.slot_datas[0] and weapon_inv_data.slot_datas[0].item_data is ItemDataWeapon:
		return true
	else:
		return false

func get_weapon_type() -> String:
	return weapon_inv_data.slot_datas[0].item_data.get_weapon_type()

func change_health(change : int):
	set_health( get_health() + change )
	#hp_changed.emit(get_health(), get_max_health())
	if get_health() <= 0:
		current_state = CombatantState.dead
		died.emit(self)

func change_hunger(change : int):
	set_hunger( get_hunger() + change )
	#hunger_changed.emit(get_hunger(), get_max_health())
	if get_hunger() <= 0:
		status_effects.append(HUNGRY_DEBUFF)

func get_combatant_name() -> String:
	return self.combatant_name

func can_act() -> bool:
	return is_atb_gauge_full() and is_alive()

func is_alive() -> bool:
	return get_health() > 0

func increase_atb(value : float):
	atb_gauge += value + get_speed()
	if is_atb_gauge_full():
		atb_gauge = MAX_ATB

func is_atb_gauge_full() -> bool:
	return atb_gauge >= MAX_ATB

func get_random_atb(): #called at start of combat for each combatant
	atb_gauge = randf_range(0, get_speed() + 10) #0 - 30
