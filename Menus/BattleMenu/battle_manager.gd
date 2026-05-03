class_name BattleManager extends Node


var party : Party = preload("uid://b87ogx8bknmnh")
var allies : Array[Combatant] = party.get_party()
var enemies : Array[Combatant] = []
var all_combatants : Array[Combatant] = allies + enemies

var battle_queue : Queue = Queue.new()

@onready var ui : BattleUI = %UI


enum BattleState{
	selecting_action,
	selecting_target,
	executing,
	enemy_turn,
	battle_over
}

var current_battle_state : BattleState = BattleState.selecting_action
var increase_atb : bool = true
var current_combatant : Combatant
var target_cursor : int = 0

var battle_speed : float = 1.0 #speed of combat

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	for combatant in all_combatants:
		if combatant and combatant.current_state == 0:
			combatant.increase_atb(battle_speed)
			combatant_ready(combatant)
	
	pass

func _unhandled_input(_event: InputEvent) -> void: #temp
	if Input.is_action_just_pressed("settings"): #for debugging
		get_tree().quit()

func start_of_combat() -> void:
	for combatant in all_combatants:
		combatant.get_equipment_effects()
	pass

func combatant_ready(combatant : Combatant):
	if combatant.is_ally:
		combatant.current_state = Combatant.CombatantState.ready
		show_action_menu()
	else:
		get_ai_action(combatant)

func hide_action_menu():
	%UI.hide_option_menu()

func show_action_menu():
	%UI.show_option_menu()

func get_ai_action(combatant : Combatant):
	pass

func get_random_combatant() -> Array[Combatant]:
	return all_combatants.filter(is_alive).pick_random()

func get_random_ally() -> Array[Combatant]:
	return allies.filter(is_alive).pick_random()

func get_random_enemy() -> Array[Combatant]:
	return enemies.filter(is_alive).pick_random()

func get_valid_targets(ability : Ability, user : Combatant) -> Array[Combatant]:
	match ability.target_type:
		Ability.TargetType.single_enemy:
			return enemies.filter(is_alive)
		Ability.TargetType.all_enemies:
			return enemies.filter(is_alive)
		Ability.TargetType.random_enemy:
			return get_random_enemy()
		Ability.TargetType.single_ally:
			return allies.filter(is_alive)
		Ability.TargetType.all_allies:
			return allies.filter(is_alive)
		Ability.TargetType.random_ally:
			return get_random_ally()
		Ability.TargetType.Self:
			return [user]
		Ability.TargetType.all_combatants:
			return all_combatants.filter(is_alive)
		Ability.TargetType.random_combatant:
			return get_random_combatant()
	return []

func is_alive(combatant : Combatant) -> bool:
	return combatant.is_alive()

func apply_abilities(ability : Ability, user : Combatant, targets : Array[Combatant]):
	var final_targets : Array[Combatant]
	
	#if user.has_status("Berserk"):
		#ability.target_type = Ability.TargetType.random_combatant
	
	if ability.target_type in [Ability.TargetType.all_enemies, 
	Ability.TargetType.all_allies, 
	Ability.TargetType.all_combatants,
	Ability.TargetType.random_enemy,
	Ability.TargetType.random_ally,
	Ability.TargetType.random_combatant]:
		final_targets = get_valid_targets(ability,user)
	else:
		final_targets = targets
	
	for target in targets:
		resolve_effect(ability,user,target)

func resolve_effect(ability : Ability, user : Combatant, target : Combatant):
	match ability.effect_type:
		Ability.AbilityType.damage:
			resolve_dmg(ability,user,target)

func resolve_dmg(ability : Ability, user : Combatant, target : Combatant):
	pass

func resolve_heal(ability : Ability, user : Combatant, target : Combatant):
	pass

func resolve_buff(ability : Ability, user : Combatant, target : Combatant):
	pass

func resolve_steal(ability : Ability, user : Combatant, target : Combatant):
	pass

func resolve_add_status(ability : Ability, user : Combatant, target : Combatant):
	pass

func resolve_remove_status(ability : Ability, user : Combatant, target : Combatant):
	pass

func resolve_revive(ability : Ability, user : Combatant, target : Combatant):
	pass
