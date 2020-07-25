extends Block

func _ready() -> void:
	power_label.hide()
	type = "power"

func setup(_color: int, _power: int = 1) -> void:
	color = _color
	self.power = 1
	paint()
	appear()
	update_label()

func paint() -> void:
	sprite.modulate = Env.Colors[color] * 1.5
	sprite.modulate.a = 1.0

func gain_power() -> void:
	pass

func destroy() -> void:
	Util.instantiate(sfx_explosion)
	var destroy_fx: = Util.instantiate(explosion)
	destroy_fx.global_position = global_position + Vector2(8.0, 8.0)
	Events.emit_signal("screen_shake", 0.5)
	Events.emit_signal(
		"shockwave",
		sprite.get_global_transform_with_canvas().origin,
		"BiggerShockWave"
	)
	Util.slow_motion(0.4, 0.8)
	repaint_blocks()
	queue_free()

func repaint_blocks() -> void:
	var blocks: = get_tree().get_nodes_in_group("block")
	for block in blocks:
		if not block.type == "common": continue
		block.color = color
		block.paint()
