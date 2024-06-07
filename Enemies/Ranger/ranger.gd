extends Enemy

@export var projectile : ProjectileBase
@export var animationTree : AnimationTree
@export var playback : AnimationNodeStateMachinePlayback
@onready var focus = preload("res://Weapons/Enemy Projectiles/focus.tscn")

var retreating : bool = false

func _ready():
	super._ready()
	speed = 10
	$Damageable.health = 1
	SignalBus.connect("focus_fire_finished", reset_speed)
	playback = animationTree["parameters/playback"]
	
func _physics_process(delta):
	if (!retreating): super._physics_process(delta)
	else:
		direction = (navigation2D.get_next_path_position() - global_position).normalized() * -1
		velocity = velocity.lerp(direction * speed, acceleration * delta)
		move_and_slide()
		update_direction()

func _on_distance_timer_timeout():
	if(position.distance_to(target.position) < 200): #make them move backwards
		retreating = true
	else:
		retreating = false


func _on_attack_timeout():
	if ((int)(randf_range(1, 11) >= 8)):
		SignalBus.emit_enemy_fire(projectile, position, (target.get_global_position() - global_position).normalized(), "res://Art/Sprites/EnemySprites/enemy_bullet.png")
		playback.travel("Fire")
		$AudioStreamPlayer.play()
	else:
		$Attack.paused = true
		speed = 0
		playback.travel("Focus")
		var marker = focus.instantiate()
		add_child(marker)

func reset_speed():
	speed = 10
	$Attack.paused = false


func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "Fire" or anim_name == "Focus"):
		playback.travel("Walk")


func _on_life_timer_timeout():
	playback.travel("Death")
