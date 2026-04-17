@tool
class_name ItemPickup extends Area2D

#@export var slot_data : SlotData :
	#set(_value):
		#slot_data = _value
		#update_visuals()

@export var item_data : ItemData :
	set(_value):
		item_data = _value
		update_visuals()

var entered : bool = false
var player : Player

func _ready() -> void:
	update_visuals()
	if Engine.is_editor_hint():
		return
	self.position = grid_snap(16)

func grid_snap(size : int) -> Vector2:
	var new_x = round(position.x / size) * size
	var new_y = round(position.y / size) * size
	return Vector2(new_x,new_y)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if Input.is_action_just_pressed("interact") and entered:
		var slot_data : SlotData = SlotData.new()
		slot_data.item_data = item_data
		if player.inventory_data.pick_up_slot_data(slot_data):
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		entered = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		entered = false
		player = null

func update_visuals():
	if not item_data or not item_data.texture:
		return
	%Sprite2D.texture = item_data.texture
