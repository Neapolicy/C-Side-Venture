extends Control

@onready var main = $"../.." #2 spots above

func _on_resume_pressed():
	main.pauseMenu()

func _on_restart_pressed():
	main.get_tree().reload_current_scene()
	main.pauseMenu()
	Hud.get_child(0).time = 0
	Hud.get_child(1).update()
	Hud.get_child(2).update()

func _on_quit_pressed():
	get_tree().quit()
