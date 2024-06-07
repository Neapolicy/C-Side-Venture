extends CharacterBody2D

class_name ExplosiveEnemy

var speed : float = 60
var acceleration : float = 7
var direction : Vector2 = Vector2.ZERO

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var navigation2D : NavigationAgent2D = $Pathfinding/NavigationAgent2D
@onready var target = get_tree().get_first_node_in_group("player_data")

@export var damage : float = 3

signal directionChange(facing_right : bool)

func _ready():
	$Damageable.health += 50 
	animation_tree.active = true
	
func _physics_process(delta):
	if (position.distance_to(target.position) < 1): pass
	else: 
		direction = (navigation2D.get_next_path_position() - global_position).normalized()
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		move_and_slide()
		update_direction()
		
func update_direction():
	if (velocity.x > 0): sprite.flip_h = false
	elif (velocity.x < 0): sprite.flip_h = true
	
func _on_timer_timeout():
	navigation2D.target_position = target.global_position
	
