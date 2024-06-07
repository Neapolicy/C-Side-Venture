extends Node2D

@onready var time_passed = Hud.get_child(0).time
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var upgrade_menu = $CanvasLayer/UpgradeMenu

var paused = false
var upgrading = false

func _ready():
	$AudioStreamPlayer.play()
	Hud.get_child(0).timer_on = true
	Hud.get_child(1).load_stuff()
	Hud.get_child(2).load_stuff()
	#toggle visibility
	Hud.get_child(0).visible = true
	Hud.get_child(1).visible = true
	Hud.get_child(2).visible = true
	
func _process(delta):
	if (Input.is_action_just_pressed("pause") and not upgrading):
		pauseMenu()
	elif (Input.is_action_just_pressed("upgrade") and not paused):
		upgradeMenu()
	time_passed = Hud.get_child(0).time

func pauseMenu(): #pause menu
	if (paused):
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	Hud.get_child(0).timer_on = !Hud.get_child(0).timer_on
	paused = !paused

func upgradeMenu(): #pause menu
	if (upgrading):
		upgrade_menu.hide()
		Engine.time_scale = 1
	else:
		upgrade_menu.show()
		Engine.time_scale = 0
		
	Hud.get_child(0).timer_on = !Hud.get_child(0).timer_on
	upgrading = !upgrading
