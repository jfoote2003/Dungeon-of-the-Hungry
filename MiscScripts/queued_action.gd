class_name QueuedAction extends Resource

var user : Combatant
var ability : Ability
var targets : Array[Combatant]

func _init(s : Combatant, a : Ability, t : Array[Combatant]):
	user = s
	ability = a
	targets = t
