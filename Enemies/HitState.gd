extends State

class_name HitState

@export var damageable : Damageable
@export var charStateMachine : CharStateMachine
@export var dead_state : Dead
@export var dead_anim_node : String = "Death"
# Called when the node enters the scene tree for the first time.
func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_damageable_hit(node : Node, damage : int):
	if (damageable.health > 0):
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_anim_node)

