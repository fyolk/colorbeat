extends Position2D

# PackedScenes
onready var block_scene: = preload("res://Environment/Block.tscn")

# Properties
var offset: = 0.0

func _ready() -> void:
	randomize()
	calc_offset()
	Events.connect("lane_change", self, "_on_Events_lane_change")

# Debug Spawn Area
#func _process(delta: float) -> void:
#	update()
#
#func _draw() -> void:
#	var rect: = Rect2(
#		Vector2(offset + Env.GRID_SIZE, 0.0),
#		Vector2(Env.LANES * Env.GRID_SIZE, 8)
#	)
#	draw_rect(rect, Color.white, true)

func spawn() -> void:
	var block: = Util.instantiate(block_scene, self)
	var pos_x: = (randi() % Env.LANES + 1) * Env.GRID_SIZE
	block.position = Vector2(offset + pos_x, 0)
	block.call_deferred("setup", randi() % 3)

func calc_offset() -> void:
	offset = (Env.MAX_LANES - Env.LANES) / 2 * Env.GRID_SIZE

func _on_Events_lane_change(lanes: int) -> void:
	calc_offset()
