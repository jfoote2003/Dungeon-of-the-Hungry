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

const PLAYER_COMBATANT = preload("uid://6m0cakotoioo")

var party : Party = Party.new()
const TESTING = preload("uid://gy51f0ps154m")


var weapon_selected : bool

func _ready():
	PlayerManager.player = self
	state_machine.Initalize(self)
	

func _process(_delta):
	direction = Vector2( Input.get_axis("left","right") , Input.get_axis("up","down")).normalized()
	weapon_selected = PLAYER_COMBATANT.weapon_equipped()

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
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interact"):
		check_interaction()

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

func heal(_heal_value : Effect):
	#heal the entire party
	pass

func fight(_weapon : ItemDataWeapon):
	weapon_selected = true
