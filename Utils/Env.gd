extends Node

# Constants
const GRID_SIZE: = 16
const MAX_LANES: = 15
const MIN_LANES: = 5
const MAX_POWER: = 9
const DEFAULT_MOVE_INTERVAL: = 2.0
const DEFAULT_BLOCKS_TO_SPAWN: = 1
const DEFAULT_POWER: = 3

# Game Properties
var Lanes: = MIN_LANES setget set_lanes
var Power: = DEFAULT_POWER setget set_power
var BlocksToSpawn: = DEFAULT_BLOCKS_TO_SPAWN
var MoveInterval: = DEFAULT_MOVE_INTERVAL
var LaneOffset: = _get_offset()
var Score: = 0
var GameOver: = false

# Enums
enum { RED, GREEN, BLUE, YELLOW }

# Properties
var DefaultColors: = {
	RED: Color("#f47c7c"),
	GREEN: Color("#a1de93"),
	BLUE: Color("#70a1d7"),
	YELLOW: Color("#f7f48b")
}

var ColorBlindColors: = {
	RED: Color("#DC267F"),
	GREEN: Color("#785EF0"),
	BLUE: Color("#648FFF"),
	YELLOW: Color("#FFB000"),
}

onready var Colors: = DefaultColors

func set_lanes(value: int) -> void:
	if value < MIN_LANES or value > MAX_LANES: return

	Lanes = value
	LaneOffset = _get_offset()
	Events.emit_signal("lane_change")

func set_power(value: int) -> void:
	if value > MAX_POWER: return
	
	Power = value

func reset() -> void:
	Lanes = MIN_LANES
	Power = DEFAULT_POWER
	BlocksToSpawn = DEFAULT_BLOCKS_TO_SPAWN
	MoveInterval = DEFAULT_MOVE_INTERVAL
	LaneOffset = _get_offset()
	Score = 0
	GameOver = false

func _get_offset() -> int:
	# warning-ignore:integer_division
	return (MAX_LANES - Lanes) / 2 * GRID_SIZE
