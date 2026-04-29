class_name StatusEffect extends Resource

@export var name : String
@export var turn_duration : int = 0 #-1 lasts indef
@export var is_beneficial : bool

@export var burning : bool = false
@export var hungry : bool = false
@export var drunk : bool = false
@export var poisoned : bool = false
@export var bleeding : bool = false
@export var frozen : bool = false

@export var effect : Effect

static func new_haste() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "haste"
	output.effect = preload("uid://cfkrss8ogl1fy")
	output.turn_duration = 10
	output.is_beneficial = true
	
	return output
