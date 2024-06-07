extends TextureProgressBar

@onready var player : Player
@onready var state : State

func load_stuff():
	player = get_tree().get_first_node_in_group("player_data")
	state = player.get_child(5).get_child(0) #get the alive state
	state.health_change.connect(update)
	update()
	
func update():
	value = state.health * 100 / state.max_health
