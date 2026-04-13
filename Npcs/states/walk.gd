class_name NpcStateWalk extends NpcState

@onready var idle = %Idle
@onready var talk = %Talk
@onready var sitt = %Sit

func _ready():
	
	pass

func init():
	
	pass

func exit():
	
	pass

func enter():
	npc.update_animation("walk")
	pass

func process(_delta : float) -> NpcState:
	
	return null

func physics(_delta : float) -> NpcState:
	
	return null
