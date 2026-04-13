class_name Party extends Resource

const PLAYER_COMBATANT = preload("uid://6m0cakotoioo")

var member1 : Combatant = PLAYER_COMBATANT
var member2 : Combatant
var member3 : Combatant
var member4 : Combatant


var party_exp : int
var exp_needed : int
var party_level : int = 1
const MAX_LEVEL : int = 99
var exp_curve : Curve = preload("uid://bx7gjilp5l6d")

signal member_added_to_party(member : String)
signal member_removed_from_party(member : String)

func _ready():
	exp_needed = exp_level_calculator()

func level_up_party():
	if party_level < MAX_LEVEL:
		member1.rpg_class.level_up()
		member2.rpg_class.level_up()
		member3.rpg_class.level_up()
		member4.rpg_class.level_up()
		exp_needed = exp_level_calculator()
		party_level += 1
	else:
		pass

func exp_level_calculator() -> int:
	var player_level_ratio = float(party_level)/MAX_LEVEL
	var output = exp_curve.sample(player_level_ratio)
	output *= 1000000
	output += 5
	return output

func remove_party_member(party_member : Combatant) -> bool:
	var found_member : bool = false
	if party_member == member1:
		member1 = null
		member_removed_from_party.emit(party_member.get_combatant_name())
		found_member = true
	elif party_member == member2:
		member2 = null
		member_removed_from_party.emit(party_member.get_combatant_name())
		found_member = true
	elif party_member == member3:
		member3 = null
		member_removed_from_party.emit(party_member.get_combatant_name())
		found_member = true
	elif party_member == member4:
		member4 = null
		member_removed_from_party.emit(party_member.get_combatant_name())
		found_member = true
	return found_member

func add_member(party_member : Combatant) -> bool:
	var member_added : bool = false
	if member1 == null:
		party_member.rpg_class.level_to_threshold(party_level)
		member1 = party_member
		member_added = true
	elif member2 == null:
		party_member.rpg_class.level_to_threshold(party_level)
		member2 = party_member
		member_added_to_party.emit(party_member.get_combatant_name())
		member_added = true
	elif member3 == null:
		party_member.rpg_class.level_to_threshold(party_level)
		member3 = party_member
		member_added_to_party.emit(party_member.get_combatant_name())
		member_added = true
	elif member4 == null:
		party_member.rpg_class.level_to_threshold(party_level)
		member4 = party_member
		member_added_to_party.emit(party_member.get_combatant_name())
		member_added = true
	else: #party full
		pass
	
	return member_added

func get_party() -> Array[Combatant]:
	return [member1,member2,member3,member4]
