class_name BattleMenu extends Control

const PARTY = preload("uid://b87ogx8bknmnh")

var allies : Array[Combatant] = PARTY.get_party()
@export var enemies : Array[Combatant] = []
var all_combatants = allies + enemies

func _ready():
	pass
