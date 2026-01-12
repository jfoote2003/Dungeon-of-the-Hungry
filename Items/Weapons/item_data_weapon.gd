class_name ItemDataWeapon extends ItemData

enum weapon_types {sword, hammer, dagger, axe, staff, bow, crossbow, spear}

@export var is_weapon : bool = true
@export var effects : Effect
@export var weapon_type : weapon_types

func use(target):
	target.fight(self)
