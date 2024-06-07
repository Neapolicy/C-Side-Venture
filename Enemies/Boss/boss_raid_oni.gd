extends Enemy

@export var projectile : ProjectileBase
@export var animationTree : AnimationTree
@export var playback : AnimationNodeStateMachinePlayback

var bullet

func _ready():
	$Damageable.health = 500
	playback = animationTree["parameters/playback"]


func _physics_process(delta):
	super._physics_process(delta)
	if ($Damageable.health <= 0):
		print("you win")
		get_tree().quit()

func update_direction():
	if (velocity.x > 0): sprite.flip_h = true
	elif (velocity.x < 0): sprite.flip_h = false
	
func _on_attack_timer_timeout():
	if ((int)(randf_range(1, 3)) == 1):
		bullet = SignalBus.emit_enemy_fire(projectile, position, (target.get_global_position() - global_position).normalized(), "res://Art/Sprites/EnemySprites/Boss/boss_bullet.png")
		playback.travel("Shoot")
		$AudioStreamPlayer2.play()
	else:
		damage = 10
		speed = 0
		$AudioStreamPlayer.play()
		playback.travel("Slam")
	$AttackTimer.paused = true


func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "Slam" or anim_name == "Shoot"):
		speed = 50
		damage = 5
		playback.travel("Walk")
		$AttackTimer.paused = false


func _on_audio_stream_player_2_finished():
	if (bullet != null):
		$AudioStreamPlayer2.play()
	else:
		$AudioStreamPlayer2.stop()
