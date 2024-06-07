extends Skills

var multiplier_value = 0

func _on_cooldown_timeout(): #secs for testing
	$Cooldown.stop()
	player.multiplier += _multiplier_value()
	$AudioStreamPlayer.play()

func _multiplier_value() -> float:
	match level:
		1:
			return .05
		2:
			return .1
		3:
			return .15
		4: 
			return .2
		5: 
			return .25
	return 0
