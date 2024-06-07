extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Hud.get_child(0).visible = false
	Hud.get_child(0).timer_on = false
	Hud.get_child(1).visible = false
	Hud.get_child(2).visible = false

func _on_return_to_main_pressed():
	resetHUD()
	get_tree().change_scene_to_file("res://UI/Menus/menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	resetHUD()
	get_tree().change_scene_to_file("res://Level/level.tscn")

func resetHUD():
	Hud.get_child(0).time = 0
	Hud.get_child(0).level = 0
