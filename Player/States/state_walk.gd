class_name StateWalk extends State

@export var move_speed : float = 100.0

@onready var idle = %Idle
@onready var attack = %Attack

func _ready():
	pass

func enter():
	player.update_animation("walk")

func exit():
	pass

func process(_delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	if player.set_direction():
		player.update_animation("walk")
	
	return null

func physics(_delta : float) -> State:
	
	return null

func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack") and player.weapon_selected:
		return attack
	return null
