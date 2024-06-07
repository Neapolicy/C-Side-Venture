class_name ProjectileManager
extends Node2D

@onready var base_bullet_scene : PackedScene = preload("res://Weapons/bullet.tscn")
@onready var base_enemy_bullet : PackedScene = preload("res://Weapons/Enemy Projectiles/enemy_bullet.tscn")
@onready var damage_boost = 0

var cost = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("fire", build_projectile)
	SignalBus.connect("enemy_fire", build_enemy_projectile)

func build_projectile(resource : ProjectileBase, location : Vector2, direction : Vector2) -> void:
	var new_bullet = base_bullet_scene.instantiate() as Bullet

	new_bullet.sprite2d = resource.projectile_sprite
	
	new_bullet.position = location
	new_bullet.direction = (direction - global_position).normalized()
	new_bullet.rotation = new_bullet.direction.angle()
	new_bullet.speed = resource.projectile_speed #a;ter bullet damage here
	new_bullet.damage += damage_boost
	
	spawn_projectile(new_bullet)

func build_enemy_projectile(resource : ProjectileBase, location : Vector2, direction : Vector2, texture : String) -> void:
	var new_bullet = base_enemy_bullet.instantiate() as Bullet

	new_bullet.sprite2d = new_bullet.set_texture(texture)
	
	new_bullet.position = location
	new_bullet.direction = (direction - global_position).normalized()
	new_bullet.rotation = new_bullet.direction.angle()
	new_bullet.speed = resource.projectile_speed #a;ter bullet damage here
	
	spawn_projectile(new_bullet)

func spawn_projectile(bullet : Bullet) -> void:
	var projectile_container = NodeExtensions.getProjectileContainer()
	
	if (projectile_container == null): 
		return
	
	projectile_container.add_child(bullet)
