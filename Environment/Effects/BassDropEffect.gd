extends AudioStreamPlayer

func _on_BassDropEffect_finished() -> void:
	queue_free()
