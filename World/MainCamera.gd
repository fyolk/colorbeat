extends Camera2D

onready var default_offset: = offset

const SHAKE_MOD: = 5.0
const SHAKE_ROT_MOD: = 3.0

var friction: = 0.7
var shake: = 0.0 setget set_shake

func _ready() -> void:
	randomize()
	Events.connect("screen_shake", self, "_on_Events_screen_shake")

func _process(delta: float) -> void:
	if shake:
		screen_shake(delta)
	else:
		offset = default_offset
		rotation_degrees = 0.0

func screen_shake(delta: float) -> void:
	var amount: = shake * SHAKE_MOD
	var rot_amount: = shake * SHAKE_ROT_MOD

	offset = default_offset + Vector2(
		rand_range(-amount, amount),
		rand_range(-amount, amount)
	)
	rotation_degrees = rand_range(-rot_amount, rot_amount)

	self.shake -= friction * delta

func set_shake(value: float) -> void:
	shake = clamp(value, 0.0, 1.0)

func _on_Events_screen_shake(amount: float) -> void:
	self.shake = amount
