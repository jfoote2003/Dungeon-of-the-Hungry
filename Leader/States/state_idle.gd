class_name State_Idle extends State

@onready var walk = %Walk
@onready var attack = %Attack

func _ready():
	
	pass


func exit():
	
	pass

func enter():
	leader.update_animation("idle")

func process(_delta) -> State:
	if leader.direction != Vector2.ZERO:
		return walk
	leader.velocity = Vector2.ZERO
	return null

func physics(_delta : float) -> State:
	
	return null

func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack") and leader.weapon_selected:
		return attack
	return null
