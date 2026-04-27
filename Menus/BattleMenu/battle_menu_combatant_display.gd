@tool
class_name BattleMenuCombatantDisplay extends Control

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
	%DefaultVisuals.custom_minimum_size = Vector2(x,y)
	if combatant:
		%DefaultVisuals.visible = false
	else:
		%DefaultVisuals.visible = true

func show_selection_arrow() -> void:
	#%SelectionArrow.visible = true
	pass

func hide_selection_arrow() -> void:
	#%SelectionArrow.visible = false
	pass

func set_arrow_color(r : int, g : int, b : int) -> void:
	r = clampi(r,0,255)
	g = clampi(g,0,255)
	b = clampi(b,0,255)
	#%SelectionArrow.modulate = Color(r,g,b,1)

func play_animation(ability_name : String, direction : String) -> void:
	%AnimationPlayer.play(combatant.combatant_name + ability_name + direction)
