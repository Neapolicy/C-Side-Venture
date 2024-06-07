extends Node2D

@onready var player = get_tree().get_first_node_in_group("player_data")

var tracking : bool = true
var damage = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Focus")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #follow the player
	if (tracking):
		global_position = player.global_position


func _on_timer_timeout():
	tracking = false
	await get_tree().create_timer(.5).timeout
	$AnimationPlayer.play("Fire")
	


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Fire"):
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		await $AudioStreamPlayer2.finished
		SignalBus.emit_signal("focus_fire_finished") #for the enemy to move again and stuff
		queue_free()


func _on_audio_stream_player_finished():
	await get_tree().create_timer(.01).timeout
	$AudioStreamPlayer.play()
