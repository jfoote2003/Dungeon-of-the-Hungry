@tool
class_name BattleMenuCombatantDisplay extends Control

@export var height : int = 32
@export var width : int = 16

var combatant : Combatant
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var selection_arrow: Sprite2D = %SelectionArrow
@onready var sprite_display: Sprite2D = %SpriteDisplay


func _ready() -> void:
	update_initial_visuals()
	if Engine.is_editor_hint():
		return
	#code

func update_initial_visuals() -> void:
	if combatant:
		pass

func show_selection_arrow() -> void:
	%SelectionArrow.visible = true

func hide_selection_arrow() -> void:
	%SelectionArrow.visible = false

func set_arrow_color(r : int, g : int, b : int) -> void:
	r = clampi(r,0,255)
	g = clampi(g,0,255)
	b = clampi(b,0,255)
	%SelectionArrow.modulate = Color(r,g,b,1)

func play_animation(ability_name : String, direction : String) -> void:
	%AnimationPlayer.play(combatant.combatant_name + ability_name + direction)
