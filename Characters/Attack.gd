extends State

@export var returnState : State
@export var returnAnimationNode : String = "Move"

@onready var timer : Timer = $Timer
func _ready():
	timer.wait_time = .5
	timer.connect("timeout", resetState)
	
func resetState():
	nextState = returnState
	
func _on_animation_tree_animation_finished(anim_name):
	nextState = returnState
