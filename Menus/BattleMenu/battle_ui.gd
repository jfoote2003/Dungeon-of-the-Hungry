class_name BattleUI extends Control

func _ready() -> void:
	for child in %VisualPlayers.get_children():
		child.play_animation("none","down")
		print("testing")

func show_option_menu():
	%Options.visible = true

func hide_option_menu():
	%Options.visible = false

func _on_fight_pressed() -> void:
	
	hide_option_menu()
	pass # Replace with function body.


func _on_ability_pressed() -> void:
	
	hide_option_menu()
	pass # Replace with function body.


func _on_item_pressed() -> void:
	
	hide_option_menu()
	pass # Replace with function body.


func _on_run_pressed() -> void:
	
	hide_option_menu()
	pass # Replace with function body.
