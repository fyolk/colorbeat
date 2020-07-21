extends Node

# Constants
const GRID_SIZE: = 16
const MAX_LANES: = 15
const MIN_LANES: = 5

# Vars
var LANES: = MIN_LANES setget set_lanes

# Enums
enum { RED, GREEN, BLUE, YELLOW }

# Properties
var Colors: = {
	RED: Color("#f47c7c"),
	GREEN: Color("#a1de93"),
	BLUE: Color("#70a1d7"),
	YELLOW: Color("#f7f48b")
}

func set_lanes(value: int):
	if value < MIN_LANES or value > MAX_LANES: return

	LANES = value
	Events.emit_signal("lane_change", value)
