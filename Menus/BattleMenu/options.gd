extends NinePatchRect

signal ability_selected(ability : Ability, user : Combatant)

@onready var fight: Button = %Fight
@onready var ability: MenuButton = %Ability
@onready var item: Button = %Item
@onready var run: Button = %Run

var ally_action_queue : Queue = Queue.new()

func _ready() -> void:
	pass

func print_ally_name(combatant : Combatant):
	#print(combatant.combatant_name)
	ally_action_queue.enqueue(combatant)
	self.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_fight_pressed() -> void:
	print("fight")
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var current_combatant : Combatant = ally_action_queue.dequeue()
	ability_selected.emit(current_combatant.make_basic_attack(),current_combatant)
	#var action : QueuedAction = QueuedAction.new(current_combatant,current_combatant.make_basic_attack(),[current_combatant])
	#action_selected.emit(action)
	#current_combatant.reset_atb()
	#current_combatant.stat_updated.emit(current_combatant)



func _on_ability_pressed() -> void:
	print("ability")
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.



func _on_item_pressed() -> void:
	print("item")
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


func _on_run_pressed() -> void:
	print("run")
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.
