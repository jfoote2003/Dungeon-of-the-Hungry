class_name StateAttack extends State

var attacking : bool = false

@export_range(1,20,.5) var deceleration_speed : float = 5.0

@onready var idle = %Idle
@onready var walk = %Walk
@onready var stun = %Stun
@onready var pickup = %Pickup
@onready var death = %Death

@onready var player_sprite = %PlayerSprite
@onready var hurt_box = %AttackHurtBox




func _ready():
	
	pass

func enter():
	player.update_animation("attack")
	player_sprite.animation_player.animation_finished.connect(end_attack)
	
	attacking = true
	
	await get_tree().create_timer(.075).timeout
	hurt_box.monitoring = true

func exit():
	player_sprite.animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	hurt_box.monitoring = false

func process(_delta : float) -> State:
	player.velocity -= player.velocity * deceleration_speed * _delta
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func physics(_delta : float) -> State:
	
	return null

func handle_input(_event : InputEvent) -> State:
	
	return null

func end_attack(_newAnimName : String):
	attacking = false
