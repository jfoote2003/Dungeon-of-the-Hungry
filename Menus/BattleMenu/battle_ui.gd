class_name BattleUI extends Control


func show_action_menu():
	%ActionMenu.visible = true

func hide_action_menu():
	%ActionMenu.visible = false

func _on_fight_pressed() -> void:
	
	hide_action_menu()
	pass # Replace with function body.


func _on_ability_pressed() -> void:
	
	hide_action_menu()
	pass # Replace with function body.


func _on_item_pressed() -> void:
	
	hide_action_menu()
	pass # Replace with function body.


func _on_run_pressed() -> void:
	
	hide_action_menu()
	pass # Replace with function body.
