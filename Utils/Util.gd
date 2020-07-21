extends Node

func instantiate(scene: PackedScene, parent: Node = null) -> Node:
	var main: = parent
	if not parent:
		main = get_tree().current_scene
	
	var instance: = scene.instance()
	main.call_deferred("add_child", instance)

	return instance

func random_pick(options: Array):
	randomize()

	return options[randi() % options.size()]
