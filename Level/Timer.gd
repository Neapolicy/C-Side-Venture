extends Label

var time = 0
var secs
var mins 
var level : int = 0
@onready var timer_on = false #eventually when I make a start screen I have to manually load this in, I'm assuming
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #will need a way to fetch time from here
	if (timer_on):
		time += delta
	secs = fmod(time, 60)
	mins = fmod(time, 3600) / 60
	
	var time_passed = "%02d : %02d" % [mins, secs]
	text = time_passed
