extends Node
class_name AsteroidSpawner

signal update_points(points: int)
signal game_won

@export var asteroid_scene : PackedScene

@export var base_asteroid_points = 50

@export var count = 7

var points = 0 
var total_asteroids_count = 0 
var destroyed_asteroids_count = 0

const utils = preload("res://Scripts/utilities.gd")

func _ready():
	total_asteroids_count = count * 7 
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
	var x
	var y
	while true:
		x = randi_range(bounds.left, bounds.right)
		y = randi_range(bounds.top, bounds.bottom)
		if x>-250 and x<250 and y>-250 and y<250:
			continue
		else:
			break
	return Vector2(x, y)

func instantiate_asteroid(size: utils.size, position : Vector2):
	var asteroid = asteroid_scene.instantiate() as Asteroid
	get_tree().root.add_child.call_deferred(asteroid)
	asteroid.global_position = position
	asteroid.size = size
	asteroid.on_asteroid_destroyed.connect(asteroid_destroyed)

func asteroid_destroyed(size: utils.size, position: Vector2):
	points += base_asteroid_points * (size + 1)
	update_points.emit(points)
	destroyed_asteroids_count += 1
	
	if destroyed_asteroids_count==total_asteroids_count:
		game_won.emit()
	
	if size <= 2:
		for i in range(2):
			instantiate_asteroid(size, position)
