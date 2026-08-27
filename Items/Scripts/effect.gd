class_name Effect extends Resource

@export var effect_name : String = "Unknown Effect"
@export_multiline var description : String = ""

#damage
@export var blunt_dmg : int = 0
@export var piercing_dmg : int = 0
@export var slash_dmg : int = 0
@export var fire_dmg : int = 0
@export var ice_dmg : int = 0
@export var lightning_dmg : int = 0
@export var holy_dmg : int = 0
@export var necrotic_dmg : int = 0
@export var chaotic_dmg : int = 0

#resistances
@export var blunt_res : int = 0
@export var piercing_res : int = 0
@export var slash_res : int = 0
@export var fire_res : int = 0
@export var ice_res : int = 0
@export var lightning_res : int = 0
@export var holy_res : int = 0
@export var necrotic_res : int = 0
@export var chaotic_res : int = 0

#stat modifiers
@export_range(-20,20,1) var strength_change : int = 0
@export_range(-20,20,1) var agility_change : int = 0
@export_range(-20,20,1) var endurance_change : int = 0
@export_range(-20,20,1) var intelligence_change : int = 0
@export_range(-20,20,1) var devotion_change : int = 0
@export_range(-20,20,1) var luck_change : int = 0
@export_range(-20,20,1) var cooking_change : int = 0

#other
@export_range(0,2) var dmg_multiplier : float = 1 #
@export var speed_change : int = 0
@export var hunger_change : int = 0
@export var max_health_change : int = 0
@export var health_change : int = 0 :
	set(_value):
		health_change = max(0,_value)

func combine(effects : Array[Effect]):
	for effect in effects:
		self.blunt_dmg += effect.blunt_dmg
		self.piercing_dmg += effect.piercing_dmg
		self.slash_dmg += effect.slash_dmg
		self.fire_dmg += effect.fire_dmg
		self.ice_dmg += effect.ice_dmg
		self.lightning_dmg += effect.lightning_dmg
		self.holy_dmg += effect.holy_dmg
		self.necrotic_dmg += effect.necrotic_dmg
		self.chaotic_dmg += effect.chaotic_dmg
		
		self.blunt_res += effect.blunt_res
		self.piercing_res += effect.piercing_res
		self.slash_res += effect.slash_res
		self.fire_res += effect.fire_res
		self.ice_res += effect.ice_res
		self.lightning_res += effect.lightning_res
		self.holy_res += effect.holy_res
		self.necrotic_res += effect.necrotic_res
		self.chaotic_res += effect.chaotic_res
		
		self.strength_change += effect.strength_change
		self.agility_change += effect.agility_change
		self.endurance_change += effect.endurance_change
		self.intelligence_change += effect.intelligence_change
		self.devotion_change += effect.devotion_change
		self.cooking_change += effect.cooking_change
		self.luck_change += effect.luck_change
		
		self.speed_change += effect.speed_change
		self.hunger_change += effect.hunger_change
		self.max_health_change += effect.max_health_change
		self.time_limit += effect.time_limit

func has_damage() -> bool:
	return has_physical_damage() or has_magic_damage()

func has_physical_damage() -> bool:
	return blunt_dmg > 0 or slash_dmg > 0 or piercing_dmg > 0

func has_magic_damage() -> bool:
	return fire_dmg > 0 or ice_dmg > 0 or lightning_dmg > 0 or holy_dmg > 0 or necrotic_dmg > 0 or chaotic_dmg > 0

func get_total_dmg(resistances : Effect) -> int: #gets applied to combatant when they take dmg, no stats applied
	#TODO if resistance null then return output else rest of code
	
	var output : int = 0
	if resistances:
		blunt_dmg -= resistances.blunt_res
		slash_dmg -= resistances.slash_res
		piercing_dmg -= resistances.piercing_res
		fire_dmg -= resistances.fire_res
		ice_dmg -= resistances.ice_res
		lightning_dmg -= resistances.lightning_res
		holy_dmg -= resistances.holy_res
		necrotic_dmg -= resistances.necrotic_res
		chaotic_dmg -= resistances.chaotic_res
	
	output = blunt_dmg + slash_dmg + piercing_dmg + fire_dmg + ice_dmg + lightning_dmg + holy_dmg + necrotic_dmg + chaotic_dmg

	return output

func has_dmg() -> bool:
	return blunt_dmg > 0 or slash_dmg > 0 or piercing_dmg > 0 or fire_dmg > 0 or ice_dmg > 0 or lightning_dmg > 0 or holy_dmg > 0 or necrotic_dmg > 0 or chaotic_dmg > 0
