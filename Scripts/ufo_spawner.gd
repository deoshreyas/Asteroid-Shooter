extends Node

@export var ufo_scene : PackedScene
@onready var timer = $Timer

@onready var paths = [$PathTop/PathFollow2D, $PathBottom/PathFollow2D]

func _on_timer_timeout():
	var ufo = ufo_scene.instantiate() as Ufo
	var pathToFollow = paths.pick_random()
	if pathToFollow.get_child_count()>0:
		return
	pathToFollow.progress = 0
	ufo.pathToFollow = pathToFollow
	pathToFollow.add_child(ufo)
	timer.setup_timer()
	timer.start()
