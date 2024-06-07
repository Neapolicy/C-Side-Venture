extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Level/level.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://UI/Menus/options.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://UI/Menus/credits.tscn")


func _on_quit_pressed():
	get_tree().quit()
