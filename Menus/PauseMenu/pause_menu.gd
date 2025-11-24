extends Control

@export var menu : VBoxContainer
@export var main_settings : VBoxContainer
@export var video_settings : VBoxContainer
@export var audio_settings : VBoxContainer
@export var controls_settings : VBoxContainer
@export var language_settings : VBoxContainer
@export var back_button : Button

@export var settings_button : Button
@export var video_button : Button
@export var audio_button : Button
@export var controls_button : Button
@export var language_button : Button

var nav_stack : Array[Control] = []
var current_panel

func _ready() -> void:
	current_panel = menu
	_show_panel(menu)
	_update_back_button()
	
	settings_button.pressed.connect(_navigate_to.bind(main_settings))
	video_button.pressed.connect(_navigate_to.bind(video_settings))
	audio_button.pressed.connect(_navigate_to.bind(audio_settings))
	#controls_button.pressed.connect(_navigate_to.bind(controls_settings)) #TODO finish control menu and finalize player controls
	#language_button.pressed.connect(_navigate_to.bind(language_settings)) #TODO make a translation sheet using google sheets

func _show_panel(panel : Control):
	panel.visible = true

func _update_back_button():
	back_button.visible = nav_stack.size() > 0

func _navigate_to(panel : Control):
	if current_panel:
		nav_stack.append(current_panel)
		current_panel.visible = false
	
	current_panel = panel
	_show_panel(current_panel)
	_update_back_button()

func _on_back_pressed():
	if nav_stack.is_empty():
		return
	
	current_panel.visible = false
	current_panel = nav_stack.pop_back()
	_show_panel(current_panel)
	_update_back_button()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	self.visible = false
	
