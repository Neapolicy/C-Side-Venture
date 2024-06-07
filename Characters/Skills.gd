extends Node

class_name Skills #base skill class

@export var player : Player
@export var state : State

@onready var cd_bar = preload("res://UI/CDStuff/line_2d.tscn")

var useable : bool = true
var unlocked : bool = false
var level : int = 0
var cost : int = 20

func skill_input(event : InputEvent):
	pass

func _input(event : InputEvent): 
	skill_input(event)

func _level():
	pass

func _create_cdBar(length : int, text : String):
	var bar = cd_bar.instantiate()
	bar.start_cooldown(length, text)
	add_child(bar)
