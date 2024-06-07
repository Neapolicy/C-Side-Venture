class_name MeleeManager
extends Node2D

@onready var base_axe_scene : PackedScene = preload("res://Weapons/axe_slash.tscn")
@onready var dmg_boost = 0

var cost = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("slash", build_attack)

func build_attack(resource : MeleeBase, location : Vector2, direction : Vector2) -> void: #sprite2d is a texture2d
	var new_axe = base_axe_scene.instantiate() as AxeSlash
	
	new_axe.sprite2d = resource.melee_sprite
	
	new_axe.position = location
	new_axe.direction = (direction - global_position).normalized()
	new_axe.rotation = new_axe.direction.angle()
	new_axe.damage += dmg_boost
	
	spawn_attack(new_axe)

func spawn_attack(axe : AxeSlash) -> void:
	var melee_container = NodeExtensions.getMeleeContainer()
	
	if (melee_container == null): 
		return
	
	melee_container.add_child(axe)
