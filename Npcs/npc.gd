class_name Npc extends Node2D

@onready var state_machine = $StateMachine
@onready var sprite = $Sprite2D

@export var can_be_in_combat : bool = false
@export var party_member : PartyMember
@export var sprite_sheet : Texture2D

@export var dialog_sprite : Texture2D

func _ready() -> void:
	state_machine.Initalize(self)
	#temp
	sprite.texture = sprite_sheet
