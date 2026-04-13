class_name HurtBox extends Area2D

@export var damage : int = 1 #TODO change to am effect that is grabbed from selected weapon in hot bar

func _ready():
	area_entered.connect( area_enter )


func area_enter(a : Area2D):
	if a is HitBox:
		a.take_damage(damage)
