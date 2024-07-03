extends Node
class_name AsteroidSpawner

@export var asteroid_scene : PackedScene

@export var count = 7 

const utils = preload("res://Scripts/utilities.gd")

func _ready():
	for i in range(count):
		var spawn_position = get_random_position()
		instantiate_asteroid(utils.size.BIG, spawn_position)

func get_random_position():
	var bounds = {}
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var zoom = camera.zoom 
	var camera_pos = camera.global_position
	var size = rect.size / zoom
	bounds.top = (camera.position.y - size.y)/2
	bounds.bottom =  (camera.position.y + size.y)/2
	bounds.right = (camera.position.x + size.x)/2
	bounds.left = (camera.position.x - size.x)/2
	var x = randi_range(bounds.left, bounds.right)
	var y = randi_range(bounds.top, bounds.bottom)
	return Vector2(x, y)

func instantiate_asteroid(size: utils.size, position : Vector2):
	var asteroid = asteroid_scene.instantiate() as Asteroid
	get_tree().root.add_child.call_deferred(asteroid)
	asteroid.global_position = position
	asteroid.size = size
	asteroid.on_asteroid_destroyed.connect(asteroid_destroyed)

func asteroid_destroyed(size: utils.size, position: Vector2):
	if size < 2:
		for i in range(2):
			instantiate_asteroid(size, position)
