extends CanvasLayer

onready var score: = $MarginContainer/Score

func _ready() -> void:
	Env.Score = 0
	update_score()
	Events.connect("score", self, "_on_Events_score")

func update_score() -> void:
	score.text = str(Env.Score).pad_zeros(5)

func _on_Events_score() -> void:
	Env.Score += 1
	update_score()
