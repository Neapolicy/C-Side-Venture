extends Skills

@export var ghost_scene : PackedScene

@onready var ghost_timer = $GhostTimer
@onready var cd = $Cooldown

var dashing = false
var tween : Tween

func _process(delta):
	if (Input.is_action_just_pressed("dash") and useable and unlocked): 
		dash()
		cd.start()
		_create_cdBar(5, "Dash")
		useable = false
	if (dashing): check_interruption(tween)

func createGhost():
	var ghost = ghost_scene.instantiate()
	ghost.set_property(player.position, player.sprite.scale, player.get_global_mouse_position().x < player.position.x) 
	get_tree().current_scene.add_child(ghost)

func _on_ghost_timer_timeout():
	createGhost()

func dash(): #need to end dash early on collision
	ghost_timer.start()
	dashing = true
	tween = get_tree().create_tween() #afaik tween is basically tweaking smtg over a period of time
	if (player.velocity.x == 0 && player.velocity.y == 0): player.velocity.x = -50 #default move direction
	tween.tween_property(player, "position", player.position + player.velocity * .8, .45) #tween position to 1.5 velocity
	check_interruption(tween)
	await tween.finished #wait for tween to finish
	dashing = false
	ghost_timer.stop()

func check_interruption(tween : Tween):
	for index in player.get_slide_collision_count():
		var collision = player.get_slide_collision(index)
		if (collision is KinematicCollision2D): 
			tween.kill()
			dashing = false
			ghost_timer.stop()
			break

func _on_cooldown_timeout():
	useable = true
