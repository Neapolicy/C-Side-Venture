extends Node2D

@export var player : Player

@onready var spawn_indicator = preload("res://Enemies/Spawn Indicator/SpawnAlert.tscn")

@onready var enemy_scene = preload("res://Enemies/slime.tscn")
@onready var enemy_two = preload("res://Enemies/Boomemy/explosive_enemy.tscn")
@onready var enemy_three = preload("res://Enemies/Ranger/ranger.tscn")
@onready var boss = preload("res://Enemies/Boss/boss_raid_oni.tscn")

var alert

func _ready():
	SignalBus.connect("spawn_anim_finished", spawn_enemy)
	
func _on_world_timer_timeout(): #remember to expand the range
	for n in randf_range(7, 10):
		alert = spawn_indicator.instantiate()
		alert.position = Vector2(player.position.x + randf_range(-500, 500), player.position.y + randf_range(-50, 50))
		add_child(alert)

func spawn_enemy(location : Vector2):
	var rng : int = randf_range(1, Hud.get_child(0).level + 2)
	rng %= 3
	match rng:
		1:
			var enemy = enemy_scene.instantiate()
			enemy.position = Vector2(location.x, location.y)
			add_child(enemy)
		2:
			var enemyB = enemy_two.instantiate()
			enemyB.position = Vector2(location.x, location.y)
			add_child(enemyB)
		0:
			var enemyC = enemy_three.instantiate()
			enemyC.position = Vector2(location.x, location.y)
			add_child(enemyC)
	
func _on_level_timer_timeout():
	Hud.get_child(0).level += 1


func _on_boss_timer_timeout():
	alert = spawn_indicator.instantiate()
	alert.position = Vector2(829, 323)
	add_child(alert)
	await alert.tree_exited
	var boss_raid_oni = boss.instantiate()
	boss_raid_oni.position = alert.position
	add_child(boss_raid_oni)
