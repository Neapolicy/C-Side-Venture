extends Node2D

class_name AlertSys

func _ready():
	$AnimationPlayer.play("Spawning")
	
func _on_animation_player_animation_finished(anim_name):
	SignalBus.emit_signal("spawn_anim_finished", position)
	queue_free()
