extends Area2D

# Constants
const MAX_POWER: = 9

# PackedScenes
onready var explosion: = preload("res://Environment/Effects/BlockBreak.tscn")

# Nodes
onready var sprite: = $Sprite
onready var tween: = $Tween
onready var player: = $AnimationPlayer
onready var power_label: = $Sprite/PowerLabel

# Properties
var power: = 1 setget set_power
var color: = 0

func _ready() -> void:
	Events.connect("fall", self, "_on_Events_fall")
	sprite.scale = Vector2(0, 0)

func setup(_color: int, _power: int = 1) -> void:
	color = _color
	self.power = _power
	paint()
	appear()
	update_label()

func paint() -> void:
	sprite.modulate = Env.Colors[color]
	sprite.modulate.a = 1.0

func appear() -> void:
	tween.interpolate_property(
		sprite,
		"scale",
		sprite.scale,
		Vector2(1.0, 1.0),
		1.0,
		Tween.TRANS_ELASTIC,
		Tween.EASE_OUT
	)
	tween.start()

func fall() -> void:
	tween.interpolate_property(
		self,
		"position",
		position,
		Vector2(position.x, position.y + Env.GRID_SIZE),
		0.6,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	tween.start()

func take_damage() -> void:
	Events.emit_signal("screen_shake", 0.1)
	self.power -= 1
	update_label()
	player.play("Damage")

func gain_power() -> void:
	self.power += 1
	update_label()
	player.play("Power")

func destroy() -> void:
	var destroy_fx: = Util.instantiate(explosion)
	destroy_fx.global_position = global_position + Vector2(8.0, 8.0)
	Events.emit_signal("score")
	Events.emit_signal("screen_shake", 0.3)
	Events.emit_signal("shockwave", sprite.get_global_transform_with_canvas().origin)
	Util.slow_motion(0.5, 0.5)
	queue_free()

func update_label() -> void:
	power_label.text = power as String

func set_power(value: int) -> void:
	if value > MAX_POWER:
		value = MAX_POWER

	power = value
	if power <= 0: destroy()

func _on_Events_fall() -> void:
	fall()

func _on_Block_area_entered(area: Area2D) -> void:
	area.queue_free()
	if area.color == color:
		call_deferred("take_damage")
	else:
		call_deferred("gain_power")

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
