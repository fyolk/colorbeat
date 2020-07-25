extends Position2D

# Constants
const POWER_CHANCE: = 0.02

# PackedScenes
onready var block_scene: = preload("res://Environment/Block.tscn")
onready var block_power: = preload("res://Environment/PowerBlock.tscn")

# Properties
var offset: = 0.0
var available_positions: = []

func _ready() -> void:
	randomize()
	calc_offset()
	update_available_positions()
	Events.connect("lane_change", self, "_on_Events_lane_change")

# Debug Spawn Area
#func _process(delta: float) -> void:
#	update()
#
#func _draw() -> void:
#	var rect: = Rect2(
#		Vector2(offset + Env.GRID_SIZE, 0.0),
#		Vector2(Env.Lanes * Env.GRID_SIZE, 8)
#	)
#	draw_rect(rect, Color.white, true)

func spawn() -> void:
	randomize()
	var blocks_instantiated: = []

	while blocks_instantiated.size() < Env.BlocksToSpawn:
		var random_pos: Vector2 = Util.random_pick(available_positions)

		if not blocks_instantiated.has(random_pos):
			blocks_instantiated.append(random_pos)
			instantiate_block(random_pos)

func instantiate_block(pos: Vector2) -> void:
	var block_type: = block_power if randf() <= POWER_CHANCE else block_scene
	var block: = Util.instantiate(block_type, self)
	block.position = pos
	block.call_deferred(
		"setup",
		randi() % Env.Colors.size(),
		randi() % Env.Power + 1
	)

func calc_offset() -> void:
	# warning-ignore:integer_division
	offset = (Env.MAX_LANES - Env.Lanes) / 2 * Env.GRID_SIZE

func update_available_positions() -> void:
	available_positions.clear()
	for i in range(Env.Lanes):
		available_positions.append(Vector2(
			(i + 1) * Env.GRID_SIZE + offset,
			0.0
		))

func _on_Events_lane_change() -> void:
	calc_offset()
	update_available_positions()
