class_name Spell extends ItemData

@export var is_spell : bool = true
@export var cooldown : float = 0
@export var target_self : bool = false
@export var max_distance : int = 0
@export var effects : Effect
@export var projectile_texture : Texture2D
@export_range(0,20,1) var num_projectiles : int
@export var speed : int = 0
@export var max_uses : int = 0

func use(target):
	if is_spell:
		target.cast(self)
