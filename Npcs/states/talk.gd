class_name NpcStateTalk extends NpcState

@onready var idle = %Idle
@onready var walk = %Walk
@onready var sit = %Sit

func _ready():
	
	pass

func init():
	
	pass

func exit():
	
	pass

func enter():
	npc.update_animation("talk")
	pass

func process(_delta : float) -> NpcState:
	
	return null

func physics(_delta : float) -> NpcState:
	
	return null
