class_name RPGClass extends Resource

#tag skills
@export_range(0,99,1) var strength : int = 0
@export_range(0,99,1) var agility : int = 0
@export_range(0,99,1) var endurance : int = 0
@export_range(0,99,1) var intelligence : int = 0
@export_range(0,99,1) var devotion : int = 0
@export_range(0,99,1) var luck : int = 0
@export_range(0,99,1) var cooking : int = 0

enum class_names {Berserker, Cleric, Cook, Landsknecht, Mage, Pact_Bound, Samurai, Thief}

@export var rpg_class_name : class_names

@export var current_level : int = 1
const MAX_LEVEL : int = 609

func use_ability():
	match rpg_class_name:
		0:
			print("Berserk")
		1:
			print("Cleric")
		2:
			print("Cook")
		3:
			print("Landsknecht")
		4:
			print("Mage")
		5:
			print("Pact bound")
		6:
			print("Samurai")
		7:
			print("Thief")
		_:
			print("Default")

func sum_total_skills() -> int:
	return strength + agility + endurance + intelligence + devotion + luck + cooking

func increase_stats(stat_increase_array : Array):
	if stat_increase_array.size() != 7:
		return
	else:
		strength += stat_increase_array[0]
		agility += stat_increase_array[1]
		endurance += stat_increase_array[2]
		intelligence += stat_increase_array[3]
		devotion += stat_increase_array[4]
		luck += stat_increase_array[5]
		cooking += stat_increase_array[6]

func get_rpg_class() -> String:
	match rpg_class_name:
		0:
			return "berserk"
		1:
			return "cleric"
		2:
			return "cook"
		3:
			return "landsknecht"
		4:
			return "mage"
		5:
			return "pact bound"
		6:
			return "samurai"
		7:
			return "thief"
		_:
			return "default"

func _to_string() -> String:
	return str(strength) + " " + str(agility) + " " + str(endurance) + " " + str(intelligence) + " " + str(devotion) + " " + str(luck) + " " + str(cooking)
