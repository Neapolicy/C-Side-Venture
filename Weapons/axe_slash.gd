class_name AxeSlash
extends CharacterBody2D
@export var damage : float = 20

@onready var sprite2d = $Sprite2D as Sprite2D
@onready var player_location = get_tree().get_first_node_in_group("player_data")

var direction : Vector2 = Vector2.RIGHT

func _ready():
	$AudioStreamPlayer.play()
	
func _process(delta): #have to wait for the updated slash sprite bc this ones not straight AHAHAHAH
	move()

func move() -> void:
	if (abs(rad_to_deg(rotation)) > 150): 
		sprite2d.flip_v = true
	position = player_location.position
	move_and_collide(direction * 30) #I cannot believe that this actually worked LMAO, but I need to get player location
	
func _on_animation_tree_animation_finished(anim_name):
	queue_free()

func _on_area_2d_area_entered(area):
	for child in area.get_parent().get_children():
		if child is Damageable:
			child.hit(damage)
