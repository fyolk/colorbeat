extends Node2D

# Constants
const GRID_SIZE: = 32
const TOTAL_COLORS: = 4

# Enums
enum { LEFT, RIGHT }
enum { RED, GREEN, BLUE, YELLOW }

# Nodes
onready var tween: = $Tween
onready var player: = $AnimationPlayer
onready var sprite: = $Sprite

# Controls
var hand: int = LEFT
var color: int = YELLOW

# Properties
var colors: = {
	RED: Color("#f47c7c"),
	GREEN: Color("#a1de93"),
	BLUE: Color("#70a1d7"),
	YELLOW: Color("#f7f48b")
}

func _ready() -> void:
	swap_color(RIGHT)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		move(LEFT)
	
	if Input.is_action_just_pressed("right"):
		move(RIGHT)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	if Input.is_action_just_pressed("swap_left"):
		swap_color(LEFT)
	
	if Input.is_action_just_pressed("swap_right"):
		swap_color(RIGHT)

func move(dir: int) -> void:
	if tween.is_active(): return

	match dir:
		LEFT:
			player.play("MoveRight")
			animate_movement(LEFT)

		RIGHT:
			player.play("MoveLeft")
			animate_movement(RIGHT)

func animate_movement(dir: int):
	var modifier: = 0.0
	match dir:
		LEFT: modifier = -1.0
		RIGHT: modifier = 1.0
	
	var destination: = Vector2(
		position.x + (GRID_SIZE * modifier),
		position.y
	)

	tween.interpolate_property(
		self,
		"position",
		position,
		destination,
		0.4,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	tween.start()

func shoot() -> void:
	player.play("ShootLeft" if hand == LEFT else "ShootRight")
	hand = RIGHT if hand == LEFT else LEFT

func swap_color(dir: int) -> void:
	var next_color: int
	if dir == LEFT:
		next_color = (color - 1) if color > 0 else (TOTAL_COLORS - 1)
	else:
		next_color = (color + 1) if color < (TOTAL_COLORS - 1) else 0

	color = next_color
	tween.interpolate_property(
		sprite,
		"modulate",
		sprite.modulate,
		colors[color],
		0.5,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	tween.start()
