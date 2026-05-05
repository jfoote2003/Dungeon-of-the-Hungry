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
var target_cursor : int = 0 #index

var battle_speed : float = 1.0

var selected_ability : Ability
var valid_targets : Array[Combatant] = []

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

func _input(event: InputEvent) -> void:
	if current_battle_state == BattleState.selecting_target:
		if event.is_action_pressed("ui_right"):
			target_cursor = (target_cursor + 1) % valid_targets.size()
		if event.is_action_pressed("ui_left"):
			target_cursor = (target_cursor - 1 + valid_targets.size()) % valid_targets.size()
		if event.is_action_pressed("ui_accept"):
			#confirm_target()
			pass

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

func confirm_target():
	if valid_targets.is_empty():
		return
	var chosen = valid_targets[target_cursor]
	apply_abilities(selected_ability, current_combatant, [chosen])
	#end_turn() #TODO make end_turn method

func select_abilities(ability : Ability):
	selected_ability = ability
	valid_targets = get_valid_targets(ability,current_combatant)
	
	if ability.target_type in [Ability.TargetType.all_enemies, Ability.TargetType.all_allies, Ability.TargetType.all_combatants]:
		apply_abilities(ability, current_combatant, [])
		#end_turn() #TODO make end_turn method
	else:
		current_battle_state = BattleState.selecting_target
		target_cursor = 0

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
	
	if user.has_status("Berserk"):
		ability.target_type = Ability.TargetType.random_combatant
	
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
		resolve_abilities(ability,user,target)

func resolve_abilities(ability : Ability, user : Combatant, target : Combatant):
	match ability.effect_type:
		Ability.AbilityType.damage:
			resolve_dmg(ability,user,target)
		Ability.AbilityType.heal:
			resolve_heal(ability,user,target)
		Ability.AbilityType.buff:
			resolve_buff(ability,user,target)
		Ability.AbilityType.steal:
			resolve_steal(ability,user,target)
		Ability.AbilityType.add_status:
			resolve_add_status(ability,user,target)
		Ability.AbilityType.remove_status:
			resolve_remove_status(ability,user,target)
		Ability.AbilityType.revive:
			resolve_revive(ability,user,target)

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
