@tool
class_name BattleMenuCombatantDisplay extends Control

var yellow : Color = Color.YELLOW

@export var x : int = 16 :
	set(_value):
		x = _value
		update_initial_visuals()

@export var y : int = 32 :
	set(_value):
		y = _value
		update_initial_visuals()

@export var combatant : Combatant :
	set(_value):
		combatant = _value
		update_initial_visuals()

@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	update_initial_visuals()
	if Engine.is_editor_hint():
		return
	#code

func update_initial_visuals() -> void:
	set_arrow_color_yellow()
	%DefaultVisuals.custom_minimum_size = Vector2(x,y)
	if combatant:
		%DefaultVisuals.visible = false
		%VBoxContainer.custom_minimum_size = combatant.texture.get_size()
		%CombatantDisplay.texture = combatant.texture
		%CombatantDisplay.visible = true
	else:
		%DefaultVisuals.visible = true
		%VBoxContainer.custom_minimum_size = Vector2(16,32)
		%CombatantDisplay.visible = false

func show_selection_arrow() -> void:
	%ArrowDisplay.visible = true

func hide_selection_arrow() -> void:
	%ArrowDisplay.visible = false

func set_arrow_color_yellow() -> void:
	%ArrowDisplay.modulate = Color.YELLOW

func play_animation(ability_name : String, direction : String) -> void:
	if combatant:
		%AnimationPlayer.play(combatant.combatant_name + "_" + ability_name + "_" + direction)
