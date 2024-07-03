extends CPUParticles2D

@onready var timer = $Timer

func _ready():
	timer.wait_time = lifetime # 6 seconds

func _process(_delta):
	if emitting and timer.is_stopped():
		timer.start()

func _on_timer_timeout():
	queue_free()
