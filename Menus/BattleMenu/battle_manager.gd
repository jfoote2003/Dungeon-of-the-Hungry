class_name BattleManager extends Node


var party : Party = preload("uid://b87ogx8bknmnh")
var allies : Array[Combatant] = party.get_party()
var enemies : Array[Combatant] = []
var all_combatants : Array[Combatant] = allies + enemies

var battle_queue : Queue = Queue.new()

@onready var ui : BattleUI = %UI


enum BattleState{
	setup,
	active,
	victory,
	defeat,
	paused
}

var current_battle_state : BattleState = BattleState.setup
var increase_atb : bool = true
var current_combatant : Combatant = null

#var available_combos : Array[ComboAbility]
#var pending_comco_combatants : Array[Combatant]
#var is_selecting_combo : bool = false

var battle_speed : float = 1.0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	
	for combatant in all_combatants:
		if combatant.current_state == 0:
			combatant.increase_atb(battle_speed)
			combatant_ready(combatant)
	
	pass

func _unhandled_input(_event: InputEvent) -> void: #temp
	if Input.is_action_just_pressed("settings"): 
		get_tree().quit()

func start_of_combat() -> void:
	
	pass

func combatant_ready(combatant : Combatant):
	if combatant.is_ally:
		combatant.current_state = combatant.BattleState.ready
		show_action_menu()
	else:
		get_ai_action(combatant)

func hide_action_menu():
	%UI.hide_action_menu()

func show_action_menu():
	%UI.show_action_menu()

func get_ai_action(combatant : Combatant):
	pass

func get_random_combatant() -> Combatant:
	return all_combatants.pick_random()

func get_random_ally() -> Combatant:
	return allies.pick_random()

func get_random_enemy() -> Combatant:
	return enemies.pick_random()

func remove_combatant(combatant : Combatant) -> bool:
	var output : bool = false
	var location = all_combatants.find(combatant)
	if location == -1:
		return output #combatant not in all_combatants
	all_combatants.pop_at(location)
	return output
