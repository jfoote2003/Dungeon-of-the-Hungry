class_name Effect extends Resource

@export var effect_name : String = "Unknown Effect"
@export_multiline var description : String = ""

#damage
@export var blunt_dmg : float = 0
@export var piercing_dmg : float = 0
@export var slash_dmg : float = 0
@export var fire_dmg : float = 0
@export var ice_dmg : float = 0
@export var lightning_dmg : float = 0
@export var holy_dmg : float = 0
@export var necrotic_dmg : float = 0
@export var chaotic_dmg : float = 0

#resistances
#as the resistance gets closer to 1 you ignore all damage od a certain type and closer to -1 you take double damage of that type
@export_range(-1,1,.05) var blunt_res : float = 0
@export_range(-1,1,.05) var piercing_res : float = 0
@export_range(-1,1,.05) var slash_res : float = 0
@export_range(-1,1,.05) var fire_res : float = 0
@export_range(-1,1,.05) var ice_res : float = 0
@export_range(-1,1,.05) var lightning_res : float = 0
@export_range(-1,1,.05) var holy_res : float = 0
@export_range(-1,1,.05) var necrotic_res : float = 0
@export_range(-1,1,.05) var chaotic_res : float = 0

#stat modifiers
@export_range(-20,20,1) var strength_change : int = 0
@export_range(-20,20,1) var agility_change : int = 0
@export_range(-20,20,1) var endurance_change : int = 0
@export_range(-20,20,1) var intelligence_change : int = 0
@export_range(-20,20,1) var devotion_change : int = 0
@export_range(-20,20,1) var luck_change : int = 0
@export_range(-20,20,1) var cooking_change : int = 0

#other
@export var speed_change : int = 0
@export var hunger_change : int = 0
@export var max_health_change : int = 0

var prim_modifier : int = 0

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
		
		self.blunt_res = clampf(self.blunt_res + effect.blunt_res, 0.0, 1.0)
		self.piercing_res = clampf(self.piercing_res + effect.piercing_res, 0.0, 1.0)
		self.slash_res = clampf(self.slash_res + effect.slash_res, 0.0, 1.0)
		self.fire_res = clampf(self.fire_res + effect.fire_res, 0.0, 1.0)
		self.ice_res = clampf(self.ice_res + effect.ice_res, 0.0, 1.0)
		self.lightning_res = clampf(self.lightning_res + effect.lightning_res, 0.0, 1.0)
		self.holy_res = clampf(self.holy_res + effect.holy_res, 0.0, 1.0)
		self.necrotic_res = clampf(self.necrotic_res + effect.necrotic_res, 0.0, 1.0)
		self.chaotic_res = clampf(self.chaotic_res + effect.chaotic_res, 0.0, 1.0)
		
		#self.burning = self.burning or effect.burning
		#self.hungry = self.hungry or effect.hungry
		#self.drunk = self.drunk or effect.drunk
		#self.poisoned = self.poisoned or effect.poisoned
		#self.bleeding = self.bleeding or effect.bleeding
		#self.frozen = self.frozen or effect.frozen
		
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

#func has_status_effect() -> bool:
	#return burning or hungry or drunk or poisoned or bleeding or frozen

func has_damage() -> bool:
	return has_physical_damage() or has_magic_damage()

func has_physical_damage() -> bool:
	return blunt_dmg > 0 or slash_dmg > 0 or piercing_dmg > 0

func has_magic_damage() -> bool:
	return fire_dmg > 0 or ice_dmg > 0 or lightning_dmg > 0 or holy_dmg > 0 or necrotic_dmg > 0 or chaotic_dmg > 0

func get_total_dmg(resistances : Effect) -> float: #gets applied to combatant when they take dmg
	var output : float = 0
	
	blunt_dmg -= (blunt_dmg * resistances.blunt_res)
	slash_dmg -= (slash_dmg * resistances.slash_res)
	piercing_dmg -= (piercing_dmg * resistances.piercing_res)
	fire_dmg -= (fire_dmg * resistances.fire_res)
	ice_dmg -= (ice_dmg * resistances.ice_res)
	lightning_dmg -= (lightning_dmg * resistances.lightning_res)
	holy_dmg -= (holy_dmg * resistances.holy_res)
	necrotic_dmg -= (necrotic_dmg * resistances.necrotic_res)
	chaotic_dmg -= (chaotic_dmg * resistances.chaotic_res)
	
	output = blunt_dmg + slash_dmg + piercing_dmg + fire_dmg + ice_dmg + lightning_dmg + holy_dmg + necrotic_dmg + chaotic_dmg + prim_modifier
	
	return output

func set_weapon_dmg(value : int): #adds primary scaling to basic attack
	prim_modifier = value
