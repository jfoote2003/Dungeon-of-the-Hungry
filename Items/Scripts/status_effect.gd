class_name StatusEffect extends RefCounted

@export var name : String
@export var turn_duration : int = 0 #-1 lasts indef

@export var burning : bool = false
@export var hungry : bool = false
@export var drunk : bool = false
@export var poisoned : bool = false
@export var bleeding : bool = false
@export var frozen : bool = false

static func new_haste() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "haste"
	return output
