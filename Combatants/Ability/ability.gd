class_name Ability extends Resource

@export var ability_name : String = "Unknown"
@export_multiline var description : String = ""
@export var hunger_cost : int
@export var dmg_effect : Effect = null
@export var status_effect : Array[Effect] = []
@export var target_type : String = "Single"
@export var animation_id: String = "default"
@export var sound_effect: String = ""

enum stats {strength,agility,endurance,intelligence,devotion,cooking,luck}

@export var scales_with_stat : stats

func use(user : PartyMember, targets : Array) -> Dictionary:
	var results = {
		"success" : true,
		"damage_dealt" : [],
		"healing_done" : [],
		"effects_applied" : []
	}
	
	if user.get_hunger() < hunger_cost:
		results.success = false
	
	user.rpg_class.hunger -= hunger_cost
	user.hunger_changer.emit(user.get_hunger(), user.rpg_class.max_hunger)
	
	for target in targets:
		if dmg_effect and dmg_effect.has_damage():
			pass
	
	return results
