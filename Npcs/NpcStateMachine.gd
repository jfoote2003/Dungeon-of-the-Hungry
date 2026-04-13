class_name NpcStateMachine extends Node

var states : Array[NpcState]
var previous_state : NpcState
var current_state : NpcState
var next_state : NpcState


func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta):
	change_state( current_state.process(delta) )


func _physics_process(delta):
	change_state( current_state.physics(delta) )

func _unhandled_input(event):
	change_state( current_state.handle_input(event) )

func Initalize(_npc : Npc) -> void:
	states = []
	
	for s in get_children():
		if s is State:
			states.append(s)
	
	if states.size() == 0:
		return
	
	states[0].npc = _npc
	states[0].state_machine = self
	
	for state in states:
		state.init()
	
	change_state(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : NpcState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	next_state = new_state
	
	if current_state:
		current_state.exit()
	
	previous_state = current_state
	current_state = new_state
	current_state.enter()
