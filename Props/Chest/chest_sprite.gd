extends Node2D

@onready var animation_player = %AnimationPlayer
var is_open : bool = false

func play_default():
	%AnimationPlayer.play("default")

func play_opening():
	%AnimationPlayer.play("opening")

func play_open():
	%AnimationPlayer.play("open")
