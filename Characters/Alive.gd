extends State

class_name Alive

signal health_change

@export var usingGun : bool = false;
@export var invincibleState : State
@export var firerate : float = 2
@export var firerate_multiplier = 1
@export var player : Player
@export var projectile : ProjectileBase = null
@export var slash : MeleeBase = null
@export var canAttack = true

@onready var attack_timer = $Timer
@onready var health : float = 100:
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_hit_health_changed", get_parent().get_parent(), value - health)
		health = value
		if (health > max_health): health = max_health
@onready var max_health : int = health
@onready var collisionCount : int = 0

var bullet_count = 3

func fire_projectile() -> void:
		for n in bullet_count: 
			SignalBus.emit_fire(projectile, player.position, (player.get_global_mouse_position() - player.global_position).normalized()) #prevents projectile from moving faster at diagonal
			await get_tree().create_timer(.1).timeout #short delay between each shot
		
func state_input(event : InputEvent):
	if (event.is_action_pressed("switch_weapon")):
		switchWeapon()
		
func switchWeapon():
	if usingGun: 
		usingGun = false #swaps to axe
		firerate = 2 * firerate_multiplier
		attack_timer.wait_time = firerate
	else: 
		usingGun = true #swaps to gun
		firerate = 1.5 * firerate_multiplier
		attack_timer.wait_time = 1.5

func _on_timer_timeout(): 
	if (canAttack):
		if (usingGun): fire_projectile()
		elif (not usingGun): attack()

func attack(): #ok because of what i used for my parameters, I end up spawning the slash directly 
	SignalBus.emit_slash(slash, player.position, (player.get_global_mouse_position() - player.global_position).normalized())

func hit(damage : int): 
	health -= damage
	if (health <= 0):
		get_tree().change_scene_to_file("res://UI/Menus/game_over.tscn")
	if ($"../../Skills/Hubris".unlocked):
		$AudioStreamPlayer2.play()
		$"../..".resetMultiplier() #reset multiplier from player class
		$"../../Skills/Hubris/Cooldown".start()
		
func _on_hurtbox_area_entered(area):
	if (area.is_in_group("enemy") && area.get_parent().get_child(0).health > 0 || !area.is_in_group("enemy")): 
		if (collisionCount < 1): 
			$AudioStreamPlayer.play()
			hit(area.get_parent().damage)
			health_change.emit() #emit this signal from vulture node
			nextState = invincibleState
			collisionCount += 1

func update_firerate():
	if !usingGun: 
		firerate = 2 * firerate_multiplier
		attack_timer.wait_time = firerate
	else: 
		firerate = 1.5 * firerate_multiplier
		attack_timer.wait_time = 1.5
