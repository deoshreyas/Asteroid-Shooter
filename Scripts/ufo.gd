extends Area2D
class_name Ufo

@onready var destruction_particles = $DestructionParticles

@export var bullet : PackedScene
@export var pathToFollow : PathFollow2D

var speed = 150.0
var current_path_point = 0

func _process(delta):
	if pathToFollow==null:
		return 
	
	var progress = delta * speed 
	pathToFollow.progress += progress

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_bullet_timer_timeout():
	pass # Replace with function body.
