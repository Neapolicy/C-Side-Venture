extends Node

signal fire(resource : ProjectileBase, location : Vector2, direction : Vector2)
signal enemy_fire(resource : ProjectileBase, location : Vector2, direction : Vector2)
signal slash(resource : MeleeBase, location : Vector2, direction : Vector2) #change projectile base
signal on_hit_health_changed(node : Node, amount_changed : int)
signal spawn_anim_finished(position : Vector2)
signal focus_fire_finished

func emit_fire(resource : ProjectileBase, location : Vector2, direction : Vector2):
	fire.emit(resource, location, direction)

func emit_slash(resource : MeleeBase, location : Vector2, direction : Vector2):
	slash.emit(resource, location, direction)

func emit_enemy_fire(resource : ProjectileBase, location : Vector2, direction : Vector2, texture : String):
	enemy_fire.emit(resource, location, direction, texture)
