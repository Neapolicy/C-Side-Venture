extends CanvasLayer

@export var cooldown_time: float = 0.0

@onready var cooldown_bar 
@onready var label

var current_cooldown: float = 0.0
	
func _process(delta):
	if current_cooldown > 0:
		current_cooldown -= delta
		cooldown_bar.value = current_cooldown * 100 / cooldown_time
	else:
		cooldown_bar.visible = false

func start_cooldown(length : int, text : String): #cd length and skill name
	cooldown_bar = $ProgressBar
	label = $ProgressBar/Label
	label.text = text
	cooldown_time = length
	current_cooldown = cooldown_time #in order for it to work, must set value of cooldown_time
	cooldown_bar.value = 1  # Reset the ProgressBar to full
