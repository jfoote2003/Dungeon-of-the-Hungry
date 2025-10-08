class_name ItemDataConsumable extends ItemData

@export var heal_value : int #TODO change to an effect rather than an int
@export var effects : Effect

func use(target):
	if heal_value != 0:
		target.heal(heal_value)
