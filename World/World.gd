extends Node2D

onready var block_spawner: = $BlockSpawner
onready var barriers: = $Barriers
onready var timer: = $Timer
onready var music: = $BGMusic

func _ready() -> void:
	VisualServer.set_default_clear_color(Color("#311d3f"))
	_on_Timer_timeout()
	timer.wait_time = Env.MoveInterval
	timer.start()
	Events.connect("game_over", self, "_on_Events_game_over")

# Debug Difficulty
func _process(delta: float) -> void:
	if Env.GameOver: return

	if Input.is_action_just_pressed("ui_accept"):
		Env.Lanes += 2
		Env.Power += 1
		Env.BlocksToSpawn += 1

func remove_all_blocks() -> void:
	var blocks: = get_tree().get_nodes_in_group("block")
	for block in blocks:
		block.fade_out()

func _on_Timer_timeout() -> void:
	Events.emit_signal("fall")
	yield(get_tree().create_timer(0.314), "timeout")
	block_spawner.spawn()

func _on_Events_game_over() -> void:
	Env.GameOver = true
	timer.stop()
	music.stop()
	yield(get_tree().create_timer(1), "timeout")
	call_deferred("remove_all_blocks")
