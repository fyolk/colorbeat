extends CanvasLayer

onready var player: = $AnimationPlayer
onready var texture: = $ColorRect

func _ready() -> void:
	Events.connect("shockwave", self, "_on_Events_shockwave")

func _on_Events_shockwave(center: Vector2) -> void:
	var pos: Vector2 = center / texture.rect_size
	pos.y = 1.0 - pos.y
	texture.material.set_shader_param("center", pos)
	player.play("ShockWave")
