class_name ItemDataConsumable extends ItemData

#@export var heal_value : int #TODO change to an effect rather than an int
@export var effects : Effect

func use(target):
	target.heal(effects)
