extends CanvasLayer

onready var score: = $MarginContainer/HBoxContainer/Score
onready var level: = $MarginContainer/HBoxContainer/Level

func _ready() -> void:
	Env.Score = 0
	update_score()
	Events.connect("score", self, "_on_Events_score")
	Events.connect("game_over", self, "_on_Events_game_over")
	Events.connect("level_up", self, "_on_Events_level_up")

func update_score() -> void:
	score.text = str(Env.Score).pad_zeros(5)

func _on_Events_score() -> void:
	Env.Score += 1
	update_score()

func _on_Events_game_over() -> void:
	score.hide()

func _on_Events_level_up(current_level: int) -> void:
	# warning-ignore:incompatible_ternary
	level.text = "Level %s" % "MAX" if current_level == 11 else current_level
