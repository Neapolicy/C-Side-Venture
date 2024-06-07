extends Label

@onready var player = $"../../../Player"

func _process(delta):
	text = str(int(player.chocos))
