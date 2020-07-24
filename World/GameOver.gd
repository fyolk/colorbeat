extends CanvasLayer

onready var container: = $CenterContainer
onready var score: = $CenterContainer/VBoxContainer/ScoreLabel

func _ready() -> void:
	Events.connect("game_over", self, "_on_Events_game_over")

func _on_Events_game_over() -> void:
	score.text = "Score: %s" % str(Env.Score)
	container.show()

func _on_TryAgainButton_button_up() -> void:
	Env.reset()
	get_tree().reload_current_scene()

func _on_ExitButton_button_up() -> void:
	get_tree().change_scene("res://World/TitleScreen.tscn")
