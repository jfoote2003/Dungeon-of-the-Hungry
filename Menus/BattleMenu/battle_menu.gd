class_name BattleMenu extends Control

const PARTY = preload("uid://b87ogx8bknmnh")

var allies : Array[Combatant] = PARTY.get_party()
@export var enemies : Array[Combatant] = []
var all_combatants = allies + enemies

func _ready():
	if allies[0]:
		allies[0].stat_updated.connect(%player_stat_display.set_default)
		print("ally 1 connected")
		%player_stat_display.visible = true
		%BattleMenuCombatantDisplay.combatant = allies[0]
	else:
		%player_stat_display.visible = false
		%BattleMenuCombatantDisplay.visible = false
	if allies[1]:
		allies[1].stat_updated.connect(%player_stat_display2.set_default)
		print("ally 2 connected")
		%player_stat_display2.visible = true
		%BattleMenuCombatantDisplay2.combatant = allies[1]
	else:
		%player_stat_display2.visible = false
		%BattleMenuCombatantDisplay2.visible = false
	if allies[2]:
		allies[2].stat_updated.connect(%player_stat_display3.set_default)
		print("ally 3 connected")
		%player_stat_display3.visible = true
		%BattleMenuCombatantDisplay3.combatant = allies[2]
	else:
		%player_stat_display3.visible = false
		%BattleMenuCombatantDisplay3.visible = false
	if allies[3]:
		allies[3].stat_updated.connect(%player_stat_display4.set_default)
		print("ally 4 connected")
		%player_stat_display4.visible = true
		%BattleMenuCombatantDisplay4.combatant = allies[3]
	else:
		%player_stat_display4.visible = false
		%BattleMenuCombatantDisplay4.visible = false
	
	
