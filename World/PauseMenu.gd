extends CanvasLayer

# Nodes
onready var bg: = $ColorRect
onready var container: = $CenterContainer

# Props
onready var is_paused: = get_tree().paused setget set_is_paused

func _ready() -> void:
	hide_menu()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.is_paused = not self.is_paused

func hide_menu() -> void:
	bg.hide()
	container.hide()

func show_menu() -> void:
	bg.show()
	container.show()

func set_is_paused(value: bool) -> void:
	if value: show_menu()
	else: hide_menu()

	is_paused = value
	get_tree().paused = value

func _on_MainMenuButton_button_up() -> void:
	self.is_paused = false
	get_tree().change_scene("res://World/TitleScreen.tscn")
