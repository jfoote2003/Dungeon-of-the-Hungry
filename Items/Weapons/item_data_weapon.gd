class_name ItemDataWeapon extends ItemData

enum weapon_types {sword, hammer, dagger, axe, staff, bow, crossbow, spear}
enum stat {strength, agility, endurance, intelligence, devotion, cooking, luck}

@export var is_weapon : bool = true
@export var effect : Effect
@export var weapon_type : weapon_types
@export var primary_stat_scale : stat
@export_range(0,100) var accuracy : int = 90

func use(target):
	target.fight(self)

func get_weapon_type():
	match weapon_type:
		0:
			return "sword"
		1:
			return "hammer"
		2:
			return "dagger"
		3:
			return "axe"
		4:
			return "staff"
		5:
			return "bow"
		6:
			return "crossbow"
		7:
			return "spear"

func get_primary_dmg_scale() -> String:
	match primary_stat_scale:
		stat.strength:
			return "strength"
		1: #agi
			return "agility"
		2: #end
			return "endurance"
		3: #int
			return "intelligence"
		4: #dev
			return "devotion"
		5: #cock
			return "cook"
		6:
			return "luck"
		_:
			return ""

func get_effect() -> Effect:
	if effect:
		return effect
	else:
		return Effect.new()
