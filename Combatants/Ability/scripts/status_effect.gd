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
@export var berserk : bool = false

@export var dmg_multiplier : float = 1
@export var  dmg_over_turn : int = 0
