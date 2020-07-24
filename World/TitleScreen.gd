extends CanvasLayer

onready var start_button: = $CenterContainer/VBoxContainer/StartMenu/NinePatchRect/StartButton
onready var start_menu: = $CenterContainer/VBoxContainer/StartMenu
onready var settings_menu: = $CenterContainer/VBoxContainer/SettingsMenu
onready var howtoplay_menu: = $CenterContainer/VBoxContainer/HowToPlayMenu

func _ready() -> void:
	start_button.grab_focus()

func _on_StartButton_button_up() -> void:
	Env.reset()
	get_tree().change_scene("res://World/World.tscn")

func _on_QuitButton_button_up() -> void:
	get_tree().quit()

func _on_SettingsButton_button_up() -> void:
	start_menu.hide()
	settings_menu.show()

func _on_BackButton_button_up() -> void:
	settings_menu.hide()
	howtoplay_menu.hide()
	start_menu.show()

func _on_ColorblindButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Env.Colors = Env.ColorBlindColors
	else:
		Env.Colors = Env.DefaultColors

func _on_HowToPlayButton_button_up() -> void:
	start_menu.hide()
	howtoplay_menu.show()
