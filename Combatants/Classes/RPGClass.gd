class_name RPGClass extends Resource

#tag skills
@export_range(1,100,1) var strength : int = 1
@export_range(1,100,1) var agility : int = 1
@export_range(1,100,1) var endurance : int = 1
@export_range(1,100,1) var intelligence : int = 1
@export_range(1,100,1) var devotion : int = 1
@export_range(1,100,1) var luck : int = 1
@export_range(1,100,1) var cooking : int = 1

enum class_names {Berserker, Cleric, Cook, Landsknecht, Mage, Pact_Bound, Samurai, Thief}

@export var rpg_class_name : class_names

var current_level : int = 1
const MAX_LEVEL : int = 99

var speed : float = 10.0 + float(agility / 10.0) # 10 + (.1 - 10)

var max_health : int = ((100 * (endurance - 1)) / 11) + 100 #100 - 1000 
var health : int

var max_hunger : int = max( ((100 * (intelligence - 1)) / 11) + 100, ((100 * (devotion - 1)) / 11) + 100 )
var hunger : int

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

func set_stats(stat_array : Array):
	strength = stat_array[0]
	agility = stat_array[1]
	endurance = stat_array[2]
	intelligence = stat_array[3]
	devotion = stat_array[4]
	cooking = stat_array[5]
	luck = stat_array[6]

func level_up() -> bool:
	if current_level >= MAX_LEVEL:
		current_level = MAX_LEVEL
		return false
	else:
		increase_stats()
		current_level += 1
		return true

func increase_stats():
	match rpg_class_name:
		0: #Berserker
			strength += randi_range(1,3)
			agility += randi_range(0,2)
			endurance += randi_range(1,2)
			intelligence += randi_range(0,1)
			devotion += randi_range(0,1)
			cooking += randi_range(0,1)
			luck += randi_range(0,2)
		1: #Cleric
			strength += randi_range(0,2)
			agility += randi_range(0,2)
			endurance += randi_range(1,2)
			intelligence += randi_range(0,2)
			devotion += randi_range(1,3)
			cooking += randi_range(0,1)
			luck += randi_range(0,2)
		2: #Cook
			strength += randi_range(0,2)
			agility += randi_range(0,1)
			endurance += randi_range(1,2)
			intelligence += randi_range(0,2)
			devotion += randi_range(0,2)
			cooking += randi_range(1,3)
			luck += randi_range(0,1)
		3: #Landsknecht
			strength += randi_range(1,2)
			agility += randi_range(1,2)
			endurance += randi_range(1,3)
			intelligence += randi_range(0,1)
			devotion += randi_range(0,2)
			cooking += randi_range(0,2)
			luck += randi_range(0,1)
		4: #Mage
			strength += randi_range(0,1)
			agility += randi_range(0,2)
			endurance += randi_range(0,1)
			intelligence += randi_range(1,3)
			devotion += randi_range(1,2)
			cooking += randi_range(0,2)
			luck += randi_range(1,2)
		5: #Pact-Bound
			strength += randi_range(0,2)
			agility += randi_range(1,2)
			endurance += randi_range(0,1)
			intelligence += randi_range(0,2)
			devotion += randi_range(1,3)
			cooking += randi_range(0,1)
			luck += randi_range(1,2)
		6: #Samurai
			strength += randi_range(0,2)
			agility += randi_range(1,3)
			endurance += randi_range(1,2)
			intelligence += randi_range(0,2)
			devotion += randi_range(1,2)
			cooking += randi_range(0,1)
			luck += randi_range(0,1)
		7: #Thief
			strength += randi_range(0,1)
			agility += randi_range(1,3)
			endurance += randi_range(0,1)
			intelligence += randi_range(0,2)
			devotion += randi_range(0,2)
			cooking += randi_range(0,2)
			luck += randi_range(1,3)
	if strength >= 100:
		strength = 100
	if agility >= 100:
		agility = 100
	if endurance >= 100:
		endurance = 100
	if intelligence >= 100:
		intelligence = 100
	if devotion >= 100:
		devotion = 100
	if cooking >= 100:
		cooking = 100
	if luck >= 100:
		luck = 100

func reset_class_stats():
	match rpg_class_name:
		0:
			#Berserker
			set_stats([15,13,14,9,11,10,9])
		1:
			#Cleric
			set_stats([12,11,12,10,15,14,10])
		2:
			#Cook
			set_stats([12,13,14,11,10,9,15])
		3:
			#Landsknecht
			set_stats([14,13,15,11,10,12,9])
		4:
			#Mage
			set_stats([9,12,10,15,13,14,11])
		5:
			#Pact-Bound
			set_stats([9,13,11,12,14,14,10])
		6:
			#Samurai
			set_stats([12,15,14,11,13,10,9])
		7:
			#Thief
			set_stats([9,15,10,13,11,14,12])

func get_stats() -> Array:
	return [strength,agility,endurance,intelligence,devotion,cooking,luck]
