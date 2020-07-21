extends Node2D

onready var block_spawner: = $BlockSpawner
onready var barriers: = $Barriers
onready var timer: = $Timer

func _ready() -> void:
	VisualServer.set_default_clear_color(Color("#311d3f"))
	_on_Timer_timeout()
	timer.wait_time = Env.MoveInterval
#	Engine.time_scale = 0.5

# Debug Barriers
#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("ui_accept"):
#		Env.Lanes += 2g

func _on_Timer_timeout() -> void:
	Events.emit_signal("fall")
	block_spawner.spawn()
