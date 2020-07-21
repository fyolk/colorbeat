extends Node

# Constants
const GRID_SIZE: = 16
const MAX_LANES: = 15
const MIN_LANES: = 5
const MAX_POWER: = 9

# Game Properties
var Lanes: = MIN_LANES setget set_lanes
var Power: = 3 setget set_power
var BlockToSpawn: = 1
var MoveInterval: = 3.0
var LaneOffset: = _get_offset()

# Enums
enum { RED, GREEN, BLUE, YELLOW }

# Properties
var Colors: = {
	RED: Color("#f47c7c"),
	GREEN: Color("#a1de93"),
	BLUE: Color("#70a1d7"),
	YELLOW: Color("#f7f48b")
}

func set_lanes(value: int) -> void:
	if value < MIN_LANES or value > MAX_LANES: return

	Lanes = value
	LaneOffset = _get_offset()
	Events.emit_signal("lane_change")

func set_power(value: int) -> void:
	if value > MAX_POWER: return
	
	Power = value

func _get_offset() -> int:
	return (MAX_LANES - Lanes) / 2 * GRID_SIZE
