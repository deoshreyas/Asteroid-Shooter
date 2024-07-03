extends Area2D
class_name Ufo

@onready var destruction_particles = $DestructionParticles

@export var bullet : PackedScene
@export var pathToFollow : PathFollow2D

var speed = 0 
var current_path_point = 0

func _process(delta):
	if pathToFollow==null:
		return 
	
	var progress = delta * speed 
	pathToFollow.progress += progress
