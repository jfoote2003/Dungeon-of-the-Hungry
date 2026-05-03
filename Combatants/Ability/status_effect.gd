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

@export var effect : Effect

static func new_haste() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "haste"
	output.effect = preload("uid://cfkrss8ogl1fy")
	output.turn_duration = 10
	output.is_beneficial = true
	
	return output

static func new_flesh_rot() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "flesh rot"
	output.effect = preload("uid://daruo3m6ftvmn")
	output.turn_duration = -1
	output.is_beneficial = false
	output.poisoned = true
	
	return output

static func new_berserk() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "Berserk"
	output.effect = preload("uid://budy3pbxyvqsx")
	output.turn_duration = 10
	output.is_beneficial = false
	output.berserk = true
	
	return output

static func new_permanent_berserk() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "Berserk"
	output.effect = preload("uid://budy3pbxyvqsx")
	output.turn_duration = -1
	output.is_beneficial = false
	output.berserk = true
	
	return output

static func new_burning() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "Burning"
	output.effect = preload("uid://pyxtinik0x2b")
	output.turn_duration = 10
	output.is_beneficial = false
	output.burning = true
	
	return output

static func new_hungry() -> StatusEffect:
	var output = StatusEffect.new()
	output.name = "Hungry"
	output.effect = preload("uid://cfkrss8ogl1fy")
	output.turn_duration = -1
	output.is_beneficial = false
	output.hungry = true
	
	return output
