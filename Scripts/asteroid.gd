extends Area2D
class_name Asteroid

var asteroid_sprites = ["res://Assets/Sprites/astro1.png", "res://Assets/Sprites/astro2.png", 
"res://Assets/Sprites/astro3.png", "res://Assets/Sprites/astro4.png"]

const utils = preload("res://Scripts/utilities.gd")

signal on_asteroid_destroyed(size: utils.size, position: Vector2)

@export var speed = 100.0
@export var speed_increment = 0.5;

var size = utils.size.BIG

var direction : Vector2

@onready var sprite = $Sprite2D

@onready var destruction_particles = $DestructionParticles

func _ready():
	var scale_value = 1 / (size + 1.0)
	scale = Vector2(scale_value, scale_value)
	
	var random_image = asteroid_sprites.pick_random()
	sprite.texture = load(random_image)
	speed = speed + speed * speed_increment * size
	
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

func _on_body_entered(body):
	if body is PlayerShip:
		body.queue_free()
		destroy_self()

func explode():
	destruction_particles.emitting = true
	destruction_particles.reparent(get_tree().root)

func destroy_self():
	explode()
	queue_free()
	var new_asteroid_size = size + 1
	on_asteroid_destroyed.emit(new_asteroid_size, global_position)
