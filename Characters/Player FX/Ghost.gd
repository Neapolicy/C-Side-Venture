extends Sprite2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D

func _ready():
	$AudioStreamPlayer.play()
	ghosting()
	
func set_property(pos, scal, facing_left : bool): #position and scale
	position = pos
	scale = scal
	if (facing_left): 
		sprite = $"."
		sprite.flip_h = true

func ghosting():
	anim_player.play("walk")
	var fade = get_tree().create_tween()
	
	fade.tween_property(self, "self_modulate", Color(1, 1, 1, 0), .75)
	await fade.finished
	
	queue_free()
