extends Skills

func restore_health():
	if (randf_range(0, 100) <= level * 2):
		state.health += level
		$"../../CharStateMachine/Alive".health_change.emit()
