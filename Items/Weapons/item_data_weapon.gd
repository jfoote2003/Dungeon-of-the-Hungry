class_name ItemDataWeapon extends ItemData

enum weapon_types {sword, hammer, dagger, axe, staff, bow, crossbow, spear}
enum stat {strength, agility, endurance, intelligence, devotion, cooking, luck}

@export var is_weapon : bool = true
@export var effect : Effect = Effect.new()
@export var weapon_type : weapon_types
@export var primary_stat_scale : stat
@export var accuracy : int = 90

func use(target):
	target.fight(self)

func get_effect() -> Effect:
	if effect:
		return effect
	else: #weapon with no effect
		return Effect.new()
