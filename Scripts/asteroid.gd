extends Node2D
class_name Asteroid

var asteroid_sprites = ["res://Assets/Sprites/astro1.png", "res://Assets/Sprites/astro2.png", 
"res://Assets/Sprites/astro3.png", "res://Assets/Sprites/astro4.png"]

const utils = preload("res://Scripts/utilities.gd")

@export var speed = 100.0

var size = utils.size.BIG

var direction : Vector2

@onready var sprite = $Sprite2D

func _ready():
	var scale_value = 1 / (size + 1.0)
	scale = Vector2(scale_value, scale_value)
	
	var random_image = asteroid_sprites.pick_random()
	sprite.texture = load(random_image)
	
	var x = randf_range(-1, 1)
	var y = randf_range(-1, 1)
	direction = Vector2(x, y)
	
func _process(delta):
	global_position += direction * speed * delta

func _physics_process(delta):
	limit_movement()
		
func limit_movement():
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
	if global_position.y > bounds.bottom:
		global_position.y = bounds.top
	elif global_position.y <= bounds.top:
		global_position.y = bounds.bottom
	if global_position.x < bounds.left:
		global_position.x = bounds.right
	elif global_position.x >= bounds.right:
		global_position.x = bounds.left
