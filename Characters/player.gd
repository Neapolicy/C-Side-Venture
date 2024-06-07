extends CharacterBody2D

class_name Player

@export var speed : float = 100.0
@export var multiplier : float = 1
@export var chocos = 2000 #coins basically, I just call it chocos bc it's canonically jus chocolate coins, also 2k for testing purposes

@onready var sprite : Sprite2D = $Sprite2D
@onready var animationTree : AnimationTree = $AnimationTree
@onready var CharStateMachine : CharStateMachine = $CharStateMachine #default state is alive

var direction : Vector2 = Vector2.ZERO

func _ready():
	animationTree.active = true #you can do it by turning animation tree active through the node itself, this is better for testing

func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down") #goes from negative to positive, 
	# in godot, left is neg, right is pos
	if direction && CharStateMachine.checkStunned(): #move if not stunned
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	if (Input.is_action_pressed("cheat")): cheat()
	move_and_slide()
	updateState()
	updateDirection()

func updateState():
	animationTree.set("parameters/Move/blend_position", Vector2(direction.x, direction.y)) #sets up for BOTh x and y

func updateDirection():
	if (get_global_mouse_position().x > self.position.x): 
		sprite.flip_h = false
	elif (get_global_mouse_position().x < self.position.x): 
		sprite.flip_h = true

func resetMultiplier():
	multiplier = 1

func add_chocos(times_called : int):
	if (times_called < 0): return 1
	return 1 + add_chocos(times_called - 1)

func cheat():
	$CharStateMachine/Alive.health += 9000
