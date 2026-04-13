class_name NpcStateSit extends NpcState

@onready var idle: NpcStateIdle = %Idle
@onready var walk: NpcStateWalk = %Walk
@onready var talk: NpcStateTalk = %Talk

func _ready():
	
	pass

func init():
	
	pass

func exit():
	
	pass

func enter():
	npc.update_animation("sit")
	pass

func process(_delta : float) -> NpcState:
	
	return null

func physics(_delta : float) -> NpcState:
	
	return null
