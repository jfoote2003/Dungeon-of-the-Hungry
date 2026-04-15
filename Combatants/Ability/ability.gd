class_name Ability extends Resource

@export var ability_name : String = "Unknown"
@export_multiline var description : String = ""
@export var hunger_cost : int = 0
@export var effect : Effect = null

@export var animation_id: String = "default"
@export var sound_effect: String = ""

enum stats {
	strength,
	agility,
	endurance,
	intelligence,
	devotion,
	cooking,
	luck
}

enum TargetType {
	single_enemy,
	all_enemies,
	single_ally,
	all_allies,
	Self,
	random_enemy,
	random_ally,
	random_combatant,
	all_combatants
}

enum AbilityType{
	damage,
	heal,
	steal,
	add_status,
	remove_status,
	revive
}

enum RPGClasses {
	all,
	berserker,
	cleric,
	cook,
	landsknecht,
	mage,
	pactbound,
	samurai,
	thief
}

@export var scales_with_stat : stats
@export var target_type : TargetType = TargetType.single_enemy
@export var ability_type : AbilityType = AbilityType.damage
@export var eligible_classes : Array[RPGClasses] = []

func use(user : Combatant, targets : Array[Combatant]):
	pass

func can_use(user : Combatant) -> bool:
	return user.get_hunger() >= hunger_cost
