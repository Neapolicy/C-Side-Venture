extends Bullet


func _ready(): #change texture here
	set_damage(2)
	if ($Sprite2D.texture == preload("res://Art/Sprites/EnemySprites/Boss/boss_bullet.png")):
		$Sprite2D.scale = Vector2(.2, .2)

func set_damage(dmg : int):
	damage = dmg


func _on_area_2d_body_entered(body):
	if (body.is_in_group("player_data")):
		queue_free()

func set_texture(texture : String):
	$Sprite2D.texture = load(texture)
