extends Node2D

onready var barrier_left: = $BarrierLeft
onready var barrier_right: = $BarrierRight
onready var tween: = $Tween

var lanes: = 0

func _ready() -> void:
	Events.connect("lane_change", self, "_on_Events_lane_change")
	lanes = Env.LANES

func change_size(size: int) -> void:
	var new_lanes: = size - lanes
	var barrier_left_mod: = 0.0
	var barrier_right_mod: = 0.0

	lanes = size

	for i in range(new_lanes):
		if i % 2 == 0.0:
			barrier_right_mod += 1
		else:
			barrier_left_mod += 1

	var barrier_right_new_pos: = Vector2(
		barrier_right.position.x + (barrier_right_mod * Env.GRID_SIZE),
		barrier_right.position.y
	)
	var barrier_left_new_pos: = Vector2(
		barrier_left.position.x - (barrier_left_mod * Env.GRID_SIZE),
		barrier_left.position.y
	)

	tween.interpolate_property(
		barrier_left,
		"position",
		barrier_left.position,
		barrier_left_new_pos,
		0.5,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.interpolate_property(
		barrier_right,
		"position",
		barrier_right.position,
		barrier_right_new_pos,
		0.5,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()

func _on_Events_lane_change(lanes: int) -> void:
	change_size(lanes)
