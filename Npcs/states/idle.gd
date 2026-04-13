class_name NpcStateIdle extends NpcState

@onready var walk = %Walk
@onready var talk = %Talk
@onready var sit = %Sit

func _ready():
	
	pass

func init():
	
	pass

func exit():
	
	pass

func enter():
	npc.update_animation("idle")
	pass

func process(_delta : float) -> NpcState:
	if npc.direction != Vector2.ZERO:
		return walk
	npc.velocity = Vector2.ZERO
	return null

func physics(_delta : float) -> NpcState:
	
	return null
