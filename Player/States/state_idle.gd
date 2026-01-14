class_name State_Idle extends State

@onready var walk = %Walk
@onready var attack = %Attack

func _ready():
	
	pass


func exit():
	
	pass

func enter():
	player.update_animation("idle")

func process(_delta) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func physics(_delta : float) -> State:
	
	return null

func handle_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack") and player.weapon_selected:
		return attack
	return null
