extends Timer
class_name UFOTimer

@export var mintime = 5
@export var maxtime = 15

func _ready():
	setup_timer()

func setup_timer():
	var timeout_val = randi_range(mintime, maxtime)
	self.wait_time = timeout_val
	self.start()
