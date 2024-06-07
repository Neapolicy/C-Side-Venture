extends Skills

@onready var duration = $Duration

func skill_input(event : InputEvent):
	if (event.is_action_pressed("skill_one") and useable and unlocked):
		$"../../CharStateMachine/Alive".usingGun = true
		useable = false
		player.speed = _level()
		state.bullet_count *= 2
		duration.start()
	
func _on_cooldown_timeout():
	useable = true

func _on_duration_timeout():
	player.speed = 100
	state.bullet_count = 3
	$Cooldown.start()

func _level():
	match level:
		1:
			return 120
		2:
			return 125
		3:
			return 130
		4:
			return 135
		5:
			return 150
