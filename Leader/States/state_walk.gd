class_name StateWalk extends State

@export var move_speed : float = 100.0

@onready var idle = %Idle
@onready var attack = %Attack

func _ready():
	pass

func enter():
	leader.update_animation("walk")

func exit():
	pass

func process(_delta : float) -> State:
	if leader.direction == Vector2.ZERO:
		return idle
	
	leader.velocity = leader.direction * move_speed
	if leader.set_direction():
		leader.update_animation("walk")
	
	return null

func physics(_delta : float) -> State:
	
	return null

func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack") and leader.weapon_selected:
		return attack
	return null
