extends Node2D

# Constants
const TOTAL_COLORS: = 4

# Enums
enum { LEFT, RIGHT }

# PackedScenes
onready var shot_scene: = preload("res://Environment/Shot.tscn")

# Nodes
onready var color_tween: = $ColorTween
onready var player: = $AnimationPlayer
onready var sprite: = $Sprite
onready var muzzle: = $Muzzle

# Controls
var hand: int = LEFT
var color: int = Env.YELLOW
var lane_boundaries: = Vector2.ZERO

func _ready() -> void:
	Events.connect("lane_change", self, "_on_Events_lane_change")
	_calc_boundaries()
	swap_color(RIGHT)

func _process(delta: float) -> void:
	if Env.GameOver: return

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
	match dir:
		LEFT:
			player.play("MoveLeft")
			animate_movement(LEFT)

		RIGHT:
			player.play("MoveRight")
			animate_movement(RIGHT)

func animate_movement(dir: int):
	var destination: = position
	var modifier: = 0.0

	match dir:
		LEFT: modifier = -1.0
		RIGHT: modifier = 1.0

	destination.x += Env.GRID_SIZE * modifier
	if destination.x < lane_boundaries.x or destination.x > lane_boundaries.y:
		return

	position = destination

func shoot() -> void:
	player.play("ShootLeft" if hand == LEFT else "ShootRight")
	hand = RIGHT if hand == LEFT else LEFT
	var shot: = Util.instantiate(shot_scene)
	shot.call_deferred("setup", color)
	shot.global_position = muzzle.global_position

func swap_color(dir: int) -> void:
	var next_color: int
	if dir == LEFT:
		next_color = (color - 1) if color > 0 else (TOTAL_COLORS - 1)
	else:
		next_color = (color + 1) if color < (TOTAL_COLORS - 1) else 0

	color = next_color
	color_tween.interpolate_property(
		sprite,
		"modulate",
		sprite.modulate,
		Env.Colors[color],
		0.2,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	color_tween.start()

func _calc_boundaries() -> void:
	var max_pos: = Env.GRID_SIZE * Env.Lanes + Env.LaneOffset
	var min_pos: = Env.LaneOffset + Env.GRID_SIZE
	lane_boundaries = Vector2(min_pos, max_pos)

func _on_Events_lane_change() -> void:
	_calc_boundaries()
