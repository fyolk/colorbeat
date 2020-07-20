extends Position2D

# PackedScenes
onready var block_scene: = preload("res://Environment/Block.tscn")

func _ready() -> void:
	randomize()

func spawn() -> void:
	var block: = Util.instantiate(block_scene, self)
	var pos_x: = (randi() % Env.LANES + 1) * Env.GRID_SIZE
	block.position = Vector2(pos_x, 0)
	block.call_deferred("setup", randi() % 3)
