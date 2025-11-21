class_name Effect extends Resource


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
@export_range(0,1,.05) var blunt_res : int = 0
@export_range(0,1,.05) var piercing_res : int = 0
@export_range(0,1,.05) var slash_res : int = 0
@export_range(0,1,.05) var fire_res : int = 0
@export_range(0,1,.05) var ice_res : int = 0
@export_range(0,1,.05) var lightning_res : int = 0
@export_range(0,1,.05) var holy_res : int = 0
@export_range(0,1,.05) var necrotic_res : int = 0
@export_range(0,1,.05) var chaotic_res : int = 0

#conditions
@export var burning : bool = false
@export var hungry : bool = false
@export var drunk : bool = false
@export var poisoned : bool = false
@export var bleeding : bool = false
@export var frozen : bool = false

#stat increase/decrease
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
@export_range(0,1,0.05) var hunger_decrease_rate_change : float = 0
@export var health_change : int = 0
@export var temporary : bool = false #false means that its a permanent effect like armor
@export var time_limit : float = 0.0 #in seconds


func combine(...effects) -> Effect:
	
	var output_effect : Effect = Effect.new()
	
	for effect in effects:
		output_effect.blunt_dmg = output_effect.blunt_dmg + effect.blunt_dmg
		output_effect.piercing_dmg = output_effect.piercing_dmg + effect.piercing_dmg
		output_effect.slash_dmg = output_effect.slash_dmg + effect.slash_dmg
		output_effect.fire_dmg = output_effect.fire_dmg + effect.fire_dmg
		output_effect.ice_dmg = output_effect.ice_dmg + effect.ice_dmg
		output_effect.lightning_dmg = output_effect.lightning_dmg + effect.lightning_dmg
		output_effect.holy_dmg = output_effect.holy_dmg + effect.holy_dmg
		output_effect.necrotic_dmg = output_effect.necrotic_dmg + effect.necrotic_dmg
		output_effect.chaotic_dmg = output_effect.chaotic_dmg + effect.chaotic_dmg
		
		output_effect.blunt_res = output_effect.blunt_res + effect.blunt_res
		output_effect.piercing_res = output_effect.piercing_res + effect.piercing_res
		output_effect.slash_res = output_effect.slash_res + effect.slash_res
		output_effect.fire_res = output_effect.fire_res + effect.fire_res
		output_effect.ice_res = output_effect.ice_res + effect.ice_res
		output_effect.lightning_res = output_effect.lightning_res + effect.lightning_res
		output_effect.holy_res = output_effect.holy_res + effect.holy_res
		output_effect.necrotic_res = output_effect.necrotic_res + effect.necrotic_res
		output_effect.chaotic_res = output_effect.chaotic_res + effect.chaotic_res
		
		output_effect.burning = output_effect.burning | effect.burning
		output_effect.hungry = output_effect.hungry | effect.hungry
		output_effect.drunk = output_effect.drunk | effect.drunk
		output_effect.poisoned = output_effect.poisoned | effect.poisoned
		output_effect.bleeding = output_effect.bleeding | effect.bleeding
		output_effect.frozen = output_effect.frozen | effect.frozen
		
		output_effect.strength_change = output_effect.strength_change + effect.strength_change
		output_effect.agility_change = output_effect.agility_change + effect.agility_change
		output_effect.endurance_change = output_effect.endurance_change + effect.endurance_change
		output_effect.intelligence_change = output_effect.intelligence_change + effect.intelligence_change
		
	return output_effect
