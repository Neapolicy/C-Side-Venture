extends Node

class_name Damageable

signal on_hit(node : Node, damageTaken : int)

@onready var health : float = 20:
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_hit_health_changed", get_parent(), value - health)
		health = value	
@onready var effect = $"../EffectsPlayer"
@onready var timer = $Timer
@onready var vulture : Skills
@onready var player : Player = get_tree().get_first_node_in_group("player_data")
@onready var audio_player : AudioStreamPlayer = AudioStreamPlayer.new()

@export var dead_anim : String = "Death"

func _ready():
	audio_player.stream = load("res://Audio/EnemyAudio/enemy_hurt.mp3") #sets the audio
	add_child(audio_player)
	audio_player.volume_db = -15.0  # Reduce volume by 10 dB
	vulture = player.get_child(6).get_child(4)
	effect.play("RESET")
	
func hit(damage : int): 
	audio_player.play()
	health -= damage * $"..".target.multiplier #gets player dmg multiplier before doing damaging
	emit_signal("on_hit", get_parent(), damage)
	timer.start()
	effect.play("Hurt") #effects
		
func _on_timer_timeout(): #effect for damaged
	effect.play("RESET")

func _on_animation_tree_animation_finished(anim_name):
		if (anim_name == dead_anim): 
			get_parent().queue_free()
			if (vulture.unlocked): 
				vulture.restore_health()
			player.chocos += player.add_chocos($"..".damage)
