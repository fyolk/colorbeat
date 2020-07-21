extends Area2D

# PackedScenes
onready var explosion: = preload("res://Environment/Effects/BlockBreak.tscn")

# Nodes
onready var sprite: = $Sprite
onready var tween: = $Tween
onready var player: = $AnimationPlayer

# Properties
var health: = 3 setget set_health
var color: = 0

func setup(_color: int) -> void:
	color = _color
	sprite.scale = Vector2(0, 0)
	paint()
	appear()
	Events.connect("fall", self, "_on_Events_fall")

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
	self.health -= 1
	player.play("Damage")

func destroy() -> void:
	var destroy_fx: = Util.instantiate(explosion)
	destroy_fx.global_position = global_position + Vector2(8.0, 8.0)
	Events.emit_signal("score")
	queue_free()

func set_health(value: int) -> void:
	health = value
	if health <= 0: destroy()

func _on_Events_fall() -> void:
	fall()

func _on_Block_area_entered(area: Area2D) -> void:
	area.queue_free()
	if area.color == color:
		call_deferred("take_damage")
