class_name QueuedAction extends Resource

var ability : Ability
var targets : Array[Combatant]

func _init(a : Ability, t : Array[Combatant]):
	ability = a
	targets = t
