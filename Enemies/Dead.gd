extends State

class_name Dead

func on_enter():
	get_parent().get_parent().speed = 0
	$"../..".damage *= 2
	if (get_parent().get_parent().is_in_group("explosive")):
		$"../../AudioStreamPlayer".play()
		await get_tree().create_timer(.1).timeout
		$"../../AudioStreamPlayer".stream = load("res://Audio/EnemyAudio/explosion.wav")
		$"../../AudioStreamPlayer".play()
		
