extends Node2D

onready var block_spawner: = $BlockSpawner
onready var barriers: = $Barriers
onready var timer: = $Timer

func _ready() -> void:
	VisualServer.set_default_clear_color(Color("#311d3f"))
	_on_Timer_timeout()
	timer.wait_time = Env.MoveInterval
#	Engine.time_scale = 0.5

# Debug Difficulty
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Env.Lanes += 2
		Env.Power += 1
		Env.BlockToSpawn += 1

func _on_Timer_timeout() -> void:
	Events.emit_signal("fall")
	yield(get_tree().create_timer(0.314), "timeout")
	block_spawner.spawn()
