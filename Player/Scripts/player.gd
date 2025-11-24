class_name Player extends CharacterBody2D

signal direction_changed(new_direction : Vector2)
signal toggle_inventory

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@onready var player_sprite = %PlayerSprite
@onready var state_machine = %StateMachine
@onready var ray_cast = %RayCast2D

var can_interact : bool = false
@export var inventory_data : InventoryData
var is_in_inv : bool = false
var is_in_settings : bool = false
signal enter_settings(is_in_settings : bool)

var current_health : int = 100
var max_health : int = current_health

var weapon_selected : bool = false
#signal weapon_used(weapon_type, weapon)

@export var rpg_class : RPGClass
signal player_level_up()
@export var exp_curve : Curve
var current_exp : int = 0
var exp_needed_for_levelup : int = 0

func _ready():
	PlayerManager.player = self
	state_machine.Initalize(self)
	
	#print(rpg_class.MAX_LEVEL)

func _process(_delta):
	direction = Vector2( Input.get_axis("left","right") , Input.get_axis("up","down")).normalized()

func _physics_process(_delta):
	move_and_slide()

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round( (direction + cardinal_direction * .1).angle() / TAU * DIR_4.size() )) #converts 360 degrees to 0 - 3
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	update_raycast_direction()
	return true

func update_animation(state : String):
	if state == "attack": #TODO add a function that gets the weapon type from selected hotbar weapon
		#print("now entering attack state")
		pass
	player_sprite.play(state + "_" + anim_direction())

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _unhandled_input(_event):
	if Input.is_action_just_pressed("settings"): 
		is_in_settings = not is_in_settings
		enter_settings.emit(is_in_settings)
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
		is_in_inv = not is_in_inv
		#print(is_in_inv)
	
	if Input.is_action_just_pressed("interact"):
		check_interaction()
	
	if Input.is_action_just_pressed("level_up_temp"):
		level_up()
		pass
	
	if Input.is_action_just_pressed("use ability"):
		#rpg_class.use_ability() #TODO add abilities lol
		pass

func check_interaction():
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.get_parent().has_method("interact"):
			collider.get_parent().interact()

func update_raycast_direction():
	match cardinal_direction:
		Vector2.RIGHT:
			ray_cast.target_position = Vector2(15,0)
		Vector2.LEFT:
			ray_cast.target_position = Vector2(-15,0)
		Vector2.UP:
			ray_cast.target_position = Vector2(0,-15)
		Vector2.DOWN:
			ray_cast.target_position = Vector2(0,15)

func heal(heal_value : Effect):
	current_health += heal_value.health_change
	print(current_health)
	if current_health > max_health:
		current_health = max_health
		print(current_health)

func fight(_weapon : ItemDataWeapon): #TODO change to a signal emited rather than true or false
	weapon_selected = true

func level_up():
	exp_needed_for_levelup = exp_level_calculator()
	player_level_up.emit()
	#print(exp_needed_for_levelup)

func exp_level_calculator() -> int:
	var player_level = rpg_class.current_level
	var max_level = rpg_class.MAX_LEVEL
	var output
	if player_level == max_level:
		print("you have reached max level, congrats")
	else:
		var player_level_ratio = float(player_level)/max_level
		output = exp_curve.sample(player_level_ratio)
		output *= 1000000
		rpg_class.current_level += 1
	return output
