extends Label

@onready var player : Player
@onready var state : State

func load_stuff():
	player = get_tree().get_first_node_in_group("player_data")
	state = player.get_child(5).get_child(0) #get the alive state
	state.health_change.connect(update)
	text = "100/100"
	
func update():
	var healthBar = state.health
	text = str(healthBar) +  "/" + str(state.max_health)
