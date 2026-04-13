class_name ItemDataHelmet extends ItemData

@export var effect : Effect

func get_effect() -> Effect:
	if effect:
		return effect
	else:
		return Effect.new()
