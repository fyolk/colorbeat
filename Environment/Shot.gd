extends Area2D

# Constants
const SPEED: = 100

# Nodes
onready var sprite: = $Sprite

# Properties
var color: int

func setup(_color: int) -> void:
	color = _color
	sprite.modulate = Env.Colors[color]

func _process(delta: float) -> void:
	position.y -= SPEED * delta

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
