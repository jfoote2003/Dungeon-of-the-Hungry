class_name BattleMenu extends Control

const PARTY = preload("uid://b87ogx8bknmnh")
const BATTLE_MENU_COMBATANT_DISPLAY = preload("uid://bv8thunph2cmc")
const TESTING_ENEMY = preload("uid://1jqo1lmoi5in")


var allies : Array[Combatant] = PARTY.get_party()
@export var enemies : Array[Combatant] = [TESTING_ENEMY]
var all_combatants = allies + enemies

func _ready():
	if allies[0]:
		allies[0].stat_updated.connect(%player_stat_display.update_display)
		%player_stat_display.update_display(allies[0])
		#print("ally 1 connected")
		%player_stat_display.visible = true
		%BattleMenuCombatantDisplay.combatant = allies[0]
	else:
		%player_stat_display.visible = false
		%BattleMenuCombatantDisplay.visible = false
	
	if allies[1]:
		allies[1].stat_updated.connect(%player_stat_display2.update_display)
		%player_stat_display2.update_display(allies[1])
		#print("ally 2 connected")
		%player_stat_display2.visible = true
		%BattleMenuCombatantDisplay2.combatant = allies[1]
	else:
		%player_stat_display2.visible = false
		%BattleMenuCombatantDisplay2.visible = false
	
	if allies[2]:
		allies[2].stat_updated.connect(%player_stat_display3.update_display)
		%player_stat_display3.update_display(allies[2])
		#print("ally 3 connected")
		%player_stat_display3.visible = true
		%BattleMenuCombatantDisplay3.combatant = allies[2]
	else:
		%player_stat_display3.visible = false
		%BattleMenuCombatantDisplay3.visible = false
	
	if allies[3]:
		allies[3].stat_updated.connect(%player_stat_display4.update_display)
		%player_stat_display4.update_display(allies[3])
		#print("ally 4 connected")
		%player_stat_display4.visible = true
		%BattleMenuCombatantDisplay4.combatant = allies[3]
	else:
		%player_stat_display4.visible = false
		%BattleMenuCombatantDisplay4.visible = false
	
	var offset : Vector2 = Vector2(0,0)
	
	for enemy in enemies:
		if enemy:
			var BMCD = BATTLE_MENU_COMBATANT_DISPLAY.instantiate()
			BMCD.combatant = enemy
			offset.x += enemy.texture.get_width()/2
			offset.y += enemy.texture.get_height()
			BMCD.position = offset
			offset += Vector2(4,4)
			
			%VisualEnemies.add_child(BMCD)
		
