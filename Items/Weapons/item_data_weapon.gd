class_name ItemDataWeapon extends ItemData

enum weapon_types {sword, hammer, dagger, axe, staff, bow, crossbow, spear}

@export var is_weapon : bool = true
@export var effects : Effect
@export var weapon_type : weapon_types

@export var max_durability : int
@export var durability : int

@export_range(0,20,1) var min_strength : int = 0
@export_range(0,20,1) var min_agility : int = 0

func use(target):
	if is_weapon and durability > 0:
		#durability = durability - 1
		target.fight(self)
