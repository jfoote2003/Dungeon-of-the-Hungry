extends Node

const PLAYER = preload("uid://duvt54fanpp2d")
var player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(.2).timeout
	player_spawned = true
	
	#check tree for a level scene, if not it deletes the player lol
	if not get_tree().get_first_node_in_group("level"):
		remove_player_instance()

func get_global_position() -> Vector2:
	return player.global_position

func use_slot_data(slot_data : SlotData):
	slot_data.item_data.use(player)

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)

func remove_player_instance() -> void:
	player.queue_free()

func set_player_position(new_pos : Vector2) -> void:
	player.position = new_pos

func unparent_player(p:Node2D):
	p.remove_child(player)

func set_as_parent(parent : Node2D):
	if player.get_parent():
		player.get_parent().remove_child(player)
	parent.add_child(player)
