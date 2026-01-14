class_name Party extends Resource

var member1 : PartyMember
var member2 : PartyMember
var member3 : PartyMember
var member4 : PartyMember


var party_exp : int
var exp_needed : int
var party_level : int = 1
const MAX_LEVEL : int = 99
var exp_curve : Curve = preload("uid://bx7gjilp5l6d")

signal member_added_to_party(member : String)

func _ready():
	exp_needed = exp_level_calculator()

func level_up_party():
	member1.rpg_class.level_up()
	member2.rpg_class.level_up()
	member3.rpg_class.level_up()
	member4.rpg_class.level_up()
	exp_needed = exp_level_calculator()
	party_level += 1

func exp_level_calculator() -> int:
	var player_level_ratio = float(party_level)/MAX_LEVEL
	var output = exp_curve.sample(player_level_ratio)
	output *= 1000000
	output += 5
	return output

func remove_member(party_member : PartyMember) -> bool:
	var found_member : bool = false
	if party_member == member1:
		member1 = null
		found_member = true
	elif party_member == member2:
		member2 = null
		found_member = true
	elif party_member == member3:
		member3 = null
		found_member = true
	elif party_member == member4:
		member4 = null
		found_member = true
	return found_member

func add_member(party_member : PartyMember):
	if member1 == null:
		member1 = party_member
	elif member2 == null:
		member2 = party_member
		member_added_to_party.emit("member2")
	elif member3 == null:
		member3 = party_member
		member_added_to_party.emit("member3")
	elif member4 == null:
		member4 = party_member
		member_added_to_party.emit("member4")
	
	#levels up member to party level upon being added to party
	while party_member.rpg_class.current_level > party_level:
		party_member.rpg_class.level_up()
	
