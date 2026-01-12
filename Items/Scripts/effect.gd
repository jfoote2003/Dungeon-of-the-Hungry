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
#as the resistance gets closer to 1 you ignore all damage od a certain type
@export_range(0,1,.05) var blunt_res : float = 0
@export_range(0,1,.05) var piercing_res : float = 0
@export_range(0,1,.05) var slash_res : float = 0
@export_range(0,1,.05) var fire_res : float = 0
@export_range(0,1,.05) var ice_res : float = 0
@export_range(0,1,.05) var lightning_res : float = 0
@export_range(0,1,.05) var holy_res : float = 0
@export_range(0,1,.05) var necrotic_res : float = 0
@export_range(0,1,.05) var chaotic_res : float = 0

#conditions/status
@export var burning : bool = false
@export var hungry : bool = false
@export var drunk : bool = false
@export var poisoned : bool = false
@export var bleeding : bool = false
@export var frozen : bool = false

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

#duration
@export var temporary : bool = false
@export var time_limit : float = 0.0 #in seconds
@export var tick_interval : float = 3.0 #secs between ticks
@export var tick_on_application : bool = false


func combine(effects : Array[Effect]) -> Effect:
	
	var output_effect : Effect = Effect.new()
	
	for effect in effects:
		output_effect.blunt_dmg += effect.blunt_dmg
		output_effect.piercing_dmg += effect.piercing_dmg
		output_effect.slash_dmg += effect.slash_dmg
		output_effect.fire_dmg += effect.fire_dmg
		output_effect.ice_dmg += effect.ice_dmg
		output_effect.lightning_dmg += effect.lightning_dmg
		output_effect.holy_dmg += effect.holy_dmg
		output_effect.necrotic_dmg += effect.necrotic_dmg
		output_effect.chaotic_dmg += effect.chaotic_dmg
		
		output_effect.blunt_res = clampf(output_effect.blunt_res + effect.blunt_res, 0.0, 1.0)
		output_effect.piercing_res = clampf(output_effect.piercing_res + effect.piercing_res, 0.0, 1.0)
		output_effect.slash_res = clampf(output_effect.slash_res + effect.slash_res, 0.0, 1.0)
		output_effect.fire_res = clampf(output_effect.fire_res + effect.fire_res, 0.0, 1.0)
		output_effect.ice_res = clampf(output_effect.ice_res + effect.ice_res, 0.0, 1.0)
		output_effect.lightning_res = clampf(output_effect.lightning_res + effect.lightning_res, 0.0, 1.0)
		output_effect.holy_res = clampf(output_effect.holy_res + effect.holy_res, 0.0, 1.0)
		output_effect.necrotic_res = clampf(output_effect.necrotic_res + effect.necrotic_res, 0.0, 1.0)
		output_effect.chaotic_res = clampf(output_effect.chaotic_res + effect.chaotic_res, 0.0, 1.0)
		
		output_effect.burning = output_effect.burning or effect.burning
		output_effect.hungry = output_effect.hungry or effect.hungry
		output_effect.drunk = output_effect.drunk or effect.drunk
		output_effect.poisoned = output_effect.poisoned or effect.poisoned
		output_effect.bleeding = output_effect.bleeding or effect.bleeding
		output_effect.frozen = output_effect.frozen or effect.frozen
		
		output_effect.strength_change += effect.strength_change
		output_effect.agility_change += effect.agility_change
		output_effect.endurance_change += effect.endurance_change
		output_effect.intelligence_change += effect.intelligence_change
		output_effect.devotion_change += effect.devotion_change
		output_effect.cooking_change += effect.cooking_change
		output_effect.luck_change += effect.luck_change
		
		output_effect.speed_change += effect.speed_change
		output_effect.hunger_change += effect.hunger_change
		output_effect.max_health_change += effect.max_health_change
		output_effect.time_limit += effect.time_limit
		
	return output_effect

func has_status_effect() -> bool:
	return burning or hungry or drunk or poisoned or bleeding or frozen

func has_damage() -> bool:
	return blunt_dmg > 0 or slash_dmg > 0 or piercing_dmg > 0 or fire_dmg > 0 or ice_dmg > 0 or lightning_dmg > 0 or holy_dmg > 0 or necrotic_dmg > 0 or chaotic_dmg > 0
