class_name HitBox extends Area2D

signal Damaged( damage : int ) #TODO replace w/ an effect rather than an int

func take_damage(damage : int): #TODO replace w/ an effect rather than an int
	print("damage",damage)
	Damaged.emit(damage)

