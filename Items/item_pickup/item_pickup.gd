extends Area2D

@export var slot_data : SlotData

var entered : bool = false
var player : Leader

func _ready() -> void:
	%Sprite2D.texture = slot_data.item_data.texture
	self.position = grid_snap(%Sprite2D.texture.get_height())

func grid_snap(size : int) -> Vector2:
	var new_x = round(position.x / size) * size
	var new_y = round(position.y / size) * size
	return Vector2(new_x,new_y)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and entered:
		if player.inventory_data.pick_up_slot_data(slot_data):
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Leader:
		entered = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body is Leader:
		entered = false
		player = null
