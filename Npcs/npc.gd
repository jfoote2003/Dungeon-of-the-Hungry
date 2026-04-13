class_name Npc extends Node2D

@onready var state_machine = $StateMachine
@onready var sprite = $Sprite2D

@export var npc_name : String = ""

@export var can_be_in_combat : bool = false
@export var combatant : Combatant

@export var dialog_sprite : Texture2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

func _ready() -> void:
	state_machine.Initalize(self) 
	update_animation("idle") #TODO remove at a later date

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func update_animation(state : String):
	%AnimationPlayer.play(npc_name + "_" + state + "_" + anim_direction())
