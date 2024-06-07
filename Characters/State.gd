extends Node

class_name State

@export var invincible : bool = false;
@export var canMove : bool = true; #true in all cases except for stunned ig?

var character : CharacterBody2D
var nextState : State
var playback : AnimationNodeStateMachinePlayback

signal interrupt_state(newState : State)

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
