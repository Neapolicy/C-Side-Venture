class_name Bullet
extends CharacterBody2D

@onready var sprite2d = $Sprite2D as Sprite2D
@onready var visibilityNotifier = $VisibleNotifier as VisibleOnScreenNotifier2D
@onready var deathTimer = $LifeTimer as Timer

var direction : Vector2 = Vector2.RIGHT
var speed : float = 300
var damage : float = 10
var collision_count = 0

func _ready():
	$AudioStreamPlayer.play()
	
func _physics_process(delta):
	move(delta)

func move(delta : float) -> void:
	move_and_collide(direction * speed * delta)

func _on_visible_notifier_screen_exited():
	deathTimer.start(0.8) #live for .8 more seconds

func _on_life_timer_timeout():
	queue_free()

func _on_area_2d_area_entered(area):
	for child in area.get_parent().get_children(): #idea is that it goes up a level, then finds all child node, with damagable being one of them
		if child is Damageable and collision_count < 1 and child.health > 0: #can only collide once
			child.hit(damage)
			collision_count += 1
			queue_free()

