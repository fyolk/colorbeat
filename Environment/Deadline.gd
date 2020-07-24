extends Area2D

func _on_Deadline_area_entered(area: Area2D) -> void:
	Events.emit_signal("game_over")
