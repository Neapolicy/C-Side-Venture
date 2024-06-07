extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.FIREBRICK
@export var heal_color : Color = Color.PALE_GREEN

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_hit_health_changed", on_signal_health_changed)

func on_signal_health_changed(node : Node, amount_changed : int): #emits the health change
	var label_instance : Label = health_changed_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	if (amount_changed >= 0): label_instance.modulate = heal_color #bug is the -1 health shows when player health is at 100 and player heals
	else: label_instance.modulate = damage_color
