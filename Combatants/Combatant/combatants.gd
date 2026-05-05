class_name Combatant extends Resource

signal died(combatant : Combatant)
signal status_effect_applied(status_name : String)

@export var combatant_name : String = "default"
@export var rpg_class : RPGClass = null

#@export var override_rpg_stat : Array[int] = [] :
	#set(_value):
		#override_rpg_stat.resize(7)
		#override_rpg_stats(_value)

@export var override_strength : int
@export var override_agility : int
@export var override_endurance : int
@export var override_intelligence : int
@export var override_devotion : int
@export var override_cooking : int
@export var override_luck : int

var override_rpg_stat_array = [override_strength, 
override_agility, 
override_endurance, 
override_intelligence,
override_devotion,
override_cooking,
override_luck]

@export var stealable_item : InventoryData = null

@export var helmet_inv_data : InventoryDataHelmet
@export var chest_inv_data : InventoryDataChestplate
@export var greeves_inv_data : InventoryDataGreeves
@export var boots_inv_data : InventoryDataBoots
@export var ring1_inv_data : InventoryDataRing
@export var ring2_inv_data : InventoryDataRing
@export var offhand_inv_data : InventoryDataOffhand
@export var weapon_inv_data : InventoryDataWeapon

@export var texture : Texture2D

enum CombatantState {
	idle, 		#atb gauge filling -> 0
	ready,		#atb gauge full, awaiting input -> 1
	acting,		#preforming action -> 2
	casting,	#using ability -> 3
	stunned,	#can't act temp -> 4
	dead		#can't act -> 5
}

var equipment_effect : Effect
var status_effects : Array[StatusEffect]

var atb_gauge : float = 0.0 #0.0 - 100.0
const MAX_ATB : float = 100.0
@export var is_ally : bool = false
@export var dodge_chance : int = 0

var current_state : CombatantState = CombatantState.idle

var prepped_abilities : Array[Ability] = []
var all_abilities  : Array[Ability] = []
var max_abilities : int = 1

const FIST = preload("uid://cb7htn8hlmxdj")

func _ready():
	
	max_abilities = rpg_class.get_current_level()
	if rpg_class:
		apply_initial_stats()

func _process(_delta):
	if is_alive and atb_gauge <= 100.0:
		pass

func apply_initial_stats(): #function ran at the start of battle
	#code to override initial rpgclass stats with the overriden ones
	
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

func get_equipment_effects(): #executed at the beginning of combat for each combatant
	var equipment_array : Array = []
	var output : Effect = Effect.new()
	
	equipment_array.append(helmet_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(chest_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(greeves_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(boots_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(ring1_inv_data.slot_datas[0].item_data.get_effect())
	equipment_array.append(ring2_inv_data.slot_datas[0].item_data.get_effect())
	
	output.combine(equipment_array)
	
	equipment_effect = output

func get_stats() -> Array:
	return rpg_class.get_stats()

func weapon_equipped() -> bool:
	if weapon_inv_data.slot_datas[0] and weapon_inv_data.slot_datas[0].item_data is ItemDataWeapon:
		return true
	else:
		return false

func get_weapon() -> ItemDataWeapon:
	if weapon_equipped():
		return weapon_inv_data.slot_datas[0].item_data
	else:
		return FIST

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
		#status_effects.append(HUNGRY_DEBUFF)
		status_effects.append(preload("uid://su7dn4tjp65w"))
 
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

func take_damage(attack_effect : Effect):
	var total_dmg : int = attack_effect.get_total_dmg(equipment_effect)
	change_health(-1 * total_dmg)

func has_status(status_name : String) -> Array:
	var output : Array = [false,null]
	var index : int = 0
	for effect in status_effects:
		if effect.name == status_name:
			output[0] = true
			output[1] = index
		index += 1
	return output

func add_status(effect : StatusEffect):
	var location_array = has_status(effect.name)
	if location_array[0] == true:
		if status_effects[location_array[1]].turn_duration == -1:
			return
		status_effects[location_array[1]].turn_duration += effect.turn_duration
	else: #status_effect not in array
		status_effects.append(effect)
		status_effect_applied.emit(effect.name)

func remove_status(status_name : String) -> bool:
	var removed : bool = false
	var location_array = has_status(status_name)
	
	if location_array[0] == true:
		status_effects.pop_at(location_array[1])
		removed = true
	
	return removed

func apply_status_effects():
	for s in status_effects:
		if s.effect.has_damage():
			take_damage(s.effect)
		
		status_effects = status_effects.filter(func(d):
			if d.turn_duration == -1: 
				return true
			d.turn_duration -= 1
			if d.turn_duration <= 0:
				return false
			return true
			)

func get_total_dmg_multi() -> float:
	var output : float = 0
	var i : int = 0
	for s in status_effects:
		if s.dmg_multiplier != 0:
			output += s.dmg_multiplier
			i += 1
	return output/i

func make_basic_attack() -> Ability:
	var output : Ability = Ability.new()
	var weapon : ItemDataWeapon = get_weapon() #returns weapon equiped otherwise is a fist
	
	output.ability_name = "basic attack"
	output.effect = weapon.effect
	
	if has_status("Berserk"):
		output.target_type = Ability.TargetType.random_combatant
	else:
		output.target_type = Ability.TargetType.single_enemy
	
	output.ability_type = Ability.AbilityType.damage
	output.accuracy = weapon.accuracy
	return output

func override_rpg_stats(stat_array : Array[int]):
	rpg_class.set_stats(stat_array)
