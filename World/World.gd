extends Node2D

onready var block_spawner: = $BlockSpawner
onready var barriers: = $Barriers

func _ready() -> void:
	VisualServer.set_default_clear_color(Color("#311d3f"))
	_on_Timer_timeout()
#	Engine.time_scale = 0.5

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Env.LANES += 2

func _on_Timer_timeout() -> void:
	Events.emit_signal("fall")
	block_spawner.spawn()
