extends Skills

func skill_input(event : InputEvent):
	if (Input.is_action_pressed("skill_two") and useable and unlocked): #and unlocked
		$"../../CharStateMachine/Alive".canAttack = false
		$"../..".multiplier -= _level()
		useable = false
		for n in 5:
			$"../../CharStateMachine/Alive".attack()
			await get_tree().create_timer(.4).timeout
		$"../../CharStateMachine/Alive".canAttack = true
		$"../..".multiplier += _level()
		$Cooldown.start()
		
func _on_cooldown_timeout():
	useable = true

func _level():
	match level:
		1:
			return .4
		2:
			return .3
		3:
			return .2
		4:
			return .15
		5:
			return .1
	pass
