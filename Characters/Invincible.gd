extends State

class_name Invincible

@export var alive_state : State
@export var player : Player

@onready var timer = $Timer
@onready var hitbox = $"../../Hurtbox"
@onready var effects = $"../../EffectsPlayer"

func _ready():
	effects.play("RESET")
	
func on_enter(): #set monitoring to false
	player.speed = 110
	hitbox.monitoring = false
	effects.play("Hurt")
	timer.start()
	
func _on_timer_timeout(): #set monitoring to true
	effects.play("RESET")
	nextState = alive_state

func on_exit():
	alive_state.collisionCount -= 1
	player.speed = 100
	hitbox.monitoring = true
	
