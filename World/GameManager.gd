extends Node

var current_level: = 1 setget set_current_level

func _process(delta: float) -> void:
	check_level()

func set_current_level(value: int) -> void:
	Events.emit_signal("level_up", value)
	current_level = value
	adjust_level(value)

func check_level() -> void:
	if Env.Score >= 15 and current_level == 1: self.current_level = 2
	elif Env.Score >= 30 and current_level == 2: self.current_level = 3
	elif Env.Score >= 50 and current_level == 3: self.current_level = 4
	elif Env.Score >= 65 and current_level == 4: self.current_level = 5
	elif Env.Score >= 80 and current_level == 5: self.current_level = 6
	elif Env.Score >= 100 and current_level == 6: self.current_level = 7
	elif Env.Score >= 130 and current_level == 7: self.current_level = 8
	elif Env.Score >= 160 and current_level == 8: self.current_level = 9
	elif Env.Score >= 200 and current_level == 9: self.current_level = 10
	elif Env.Score >= 250 and current_level == 10: self.current_level = 11

func adjust_level(level: int) -> void:
	match level:
		2:
			Env.BlocksToSpawn = 2
			Env.MoveInterval = 2.5
		3:
			Env.Lanes += 2
		4:
			Env.Power = 4
		5:
			Env.Lanes += 2
			Env.MoveInterval = 3.0
		6:
			Env.BlocksToSpawn = 3
		7:
			Env.MoveInterval = 2.5
			Env.Power = 4
		8:
			Env.Lanes += 2
		9:
			Env.Power = 6
		10:
			Env.Lanes += 2
			Env.BlocksToSpawn = 4
			Env.MoveInterval = 3.0
		11:
			Env.Lanes += 2
			Env.BlocksToSpawn = 5
