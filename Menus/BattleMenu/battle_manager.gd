class_name BattleManager extends Node

signal game_over
signal win

signal ally_turn_started(combatant : Combatant)

var party : Party = preload("uid://b87ogx8bknmnh")
var allies : Array[Combatant] = party.get_party()
var enemies : Array[Combatant] = []
var all_combatants : Array[Combatant] = allies + enemies

var battle_queue : Queue = Queue.new()

@onready var ui : BattleUI = %UI

enum BattleState{running, battle_over}

var current_battle_state : BattleState = BattleState.running
var increase_atb : bool = true
var current_combatant : Combatant
var target_cursor : int = 0 #index

var battle_speed : float = 1.0

var selected_ability : Ability
var valid_targets : Array[Combatant] = []

#set up

func _ready() -> void:
	initialize_combat()
	print("battle start")
	battle_loop()

func battle_loop():
	while current_battle_state == BattleState.running:
		for combatant in all_combatants:
			if combatant:
			
				if not combatant.is_alive():
					continue
			
				process_combatant_turn(combatant)
			
				if check_battle_conditions():
					return
		
		await get_tree().process_frame

func process_combatant_turn(combatant : Combatant):
	combatant.tick_status_effects()
	
	if not combatant.is_alive():
		return
	
	if not combatant.atb_gauge == combatant.MAX_ATB:
		combatant.increase_atb(combatant.get_speed())
		return
	
	if combatant.has_status(preload("uid://cmrd3jvxsygkx")): #berserk
		resolve_abilities(combatant.make_basic_attack(), combatant, get_random_combatant())
		return
	
	if combatant.has_status(preload("uid://yj0upoagb63x")):
		combatant.queued_action = null
		return
	
	if not combatant.is_ally: #enemy ai turn
		run_enemy_turn(combatant)
	
	if combatant.queued_action != null:
		var action = combatant.queued_action
		combatant.queued_action = null
		apply_abilities(action.ability, combatant, action.targets)
	else:
		ally_turn_started.emit(combatant)

func _unhandled_input(_event: InputEvent) -> void: #temp
	if Input.is_action_just_pressed("settings"): #for debugging
		get_tree().quit()

#func _input(event: InputEvent) -> void:
	#if current_battle_state == BattleState.selecting_target:
		#if event.is_action_pressed("ui_right"):
			#target_cursor = (target_cursor + 1) % valid_targets.size()
		#if event.is_action_pressed("ui_left"):
			#target_cursor = (target_cursor - 1 + valid_targets.size()) % valid_targets.size()
		#if event.is_action_pressed("ui_accept"):
			#confirm_target()
			#pass

func initialize_combat() -> void:
	for combatant in all_combatants:
		if combatant:
			combatant.get_equipment_effects() #applies all resistances
			combatant.get_random_atb() #randomly sets atb for each combatant

func hide_action_menu():
	%UI.hide_option_menu()

func show_action_menu():
	%UI.show_option_menu()

func get_random_combatant() -> Combatant:
	return all_combatants.filter(is_alive).pick_random()

func get_random_ally() -> Combatant:
	return allies.filter(is_alive).pick_random()

func get_random_enemy() -> Combatant:
	return enemies.filter(is_alive).pick_random()

func get_valid_targets(ability : Ability, user : Combatant) -> Array[Combatant]:
	match ability.target_type:
		Ability.TargetType.single_enemy:
			return enemies.filter(is_alive)
		Ability.TargetType.all_enemies:
			return enemies.filter(is_alive)
		Ability.TargetType.random_enemy:
			return [get_random_enemy()]
		Ability.TargetType.single_ally:
			return allies.filter(is_alive)
		Ability.TargetType.all_allies:
			return allies.filter(is_alive)
		Ability.TargetType.random_ally:
			return [get_random_ally()]
		Ability.TargetType.Self:
			return [user]
		Ability.TargetType.all_combatants:
			return all_combatants.filter(is_alive)
		Ability.TargetType.random_combatant:
			return [get_random_combatant()]
	return []

func is_alive(combatant : Combatant) -> bool:
	return combatant.is_alive()

func apply_abilities(ability : Ability, user : Combatant, targets : Array[Combatant]):
	#@warning_ignore("unused_variable")
	#var final_targets : Array[Combatant]
	#
	#if user.has_status(preload("uid://cmrd3jvxsygkx")):
		#ability.target_type = Ability.TargetType.random_combatant
	#
	#if ability.target_type in [Ability.TargetType.all_enemies, 
	#Ability.TargetType.all_allies, 
	#Ability.TargetType.all_combatants,
	#Ability.TargetType.random_enemy,
	#Ability.TargetType.random_ally,
	#Ability.TargetType.random_combatant]:
		#final_targets = get_valid_targets(ability,user)
	#else:
		#final_targets = targets
	
	user.change_hunger(-1 * ability.hunger_cost)
	
	for target in targets:
		resolve_abilities(ability,user,target)

func resolve_abilities(ability : Ability, user : Combatant, target : Combatant):
	match ability.effect_type:
		Ability.AbilityType.damage:
			resolve_dmg(ability,user,target)
		Ability.AbilityType.heal:
			resolve_heal(ability,user,target)
		#Ability.AbilityType.buff:
			#resolve_buff(ability,user,target)
		Ability.AbilityType.steal:
			resolve_steal(ability,user,target)
		Ability.AbilityType.add_status:
			resolve_add_status(ability,user,target)
		Ability.AbilityType.remove_status:
			resolve_remove_status(ability,user,target)
		Ability.AbilityType.revive:
			resolve_revive(ability,user,target)

func resolve_dmg(ability : Ability, user : Combatant, target : Combatant):
	var raw : int = int(ability.effect.get_total_dmg(target.equipment_effect) * user.get_total_dmg_multi())
	@warning_ignore("integer_division")
	var dmg : int = int(max(1, raw * randf_range(.9, float(user.rpg_class.luck + 50 / 100))))
	target.take_damage(dmg)

func resolve_heal(ability : Ability, user : Combatant, target : Combatant):
	var amount : int = ability.effect.health_change + int(max(user.rpg_class.devotion, user.rpg_class.intelligence))
	target.change_health(amount)

#func resolve_buff(ability : Ability, _user : Combatant, target : Combatant):
	#target.add_status(ability.status_effect)

func resolve_steal(_ability : Ability, _user : Combatant, target : Combatant):
	if target.stealable_item:
		print("target has following item: %s" % [target.stealable_item.slot_datas[0].item_data.name]) #temp
	else:
		pass

func resolve_add_status(ability : Ability, _user : Combatant, target : Combatant):
	target.add_status(ability.status_effect)

func resolve_remove_status(ability : Ability, _user : Combatant, target : Combatant):
	target.remove_status(ability.status_effect)

func resolve_revive(_ability : Ability, _user : Combatant, target : Combatant):
	if target.is_alive():
		return
	target.set_health(1)

func can_afford(user : Combatant, ability : Ability) -> bool:
	return user.get_hunger() >= ability.hunger_cost

func check_battle_conditions() -> bool:
	var all_enemies_dead = enemies.all(func(e) : return not e.is_alive())
	var all_allies_dead = allies.all(func(a) : return not a.is_alive())
	
	if all_enemies_dead:
		win.emit()
		return true
	if all_allies_dead:
		game_over.emit()
		return true
	return false

func queue_player_action(user : Combatant, ability : Ability, targets : Array[Combatant]):
	if not can_afford(user, ability):
		return
	
	user.queued_action = QueuedAction.new(ability,targets)

func run_enemy_turn(combatant : Combatant):
	var usable = combatant.prepped_abilities.filter(func(c) : return can_afford(combatant,c))
	
	if usable.is_empty(): #no usable abilities, so use basic attack
		return
	
	var chosen_ability : Ability = usable.pick_random()
	var targets = get_valid_targets(chosen_ability, combatant)
	
	if targets.is_empty():
		return
	
	var is_all = chosen_ability.target_type in [Ability.TargetType.all_enemies, Ability.TargetType.all_allies, Ability.TargetType.all_combatants]
	var final_targets = targets if is_all else [targets.pick_random()]
	
	for target in final_targets:
		resolve_abilities(chosen_ability, combatant, target)
