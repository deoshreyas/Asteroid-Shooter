extends Area2D
class_name Ufo

@onready var destruction_particles = $DestructionParticles

@export var bullet_scene : PackedScene
@export var pathToFollow : PathFollow2D

var speed = 50.0
var current_path_point = 0

func _process(delta):
	if pathToFollow==null:
		return 
	
	var progress = delta * speed 
	pathToFollow.progress += progress

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_bullet_timer_timeout():
	var bullet = bullet_scene.instantiate() as Bullet 
	bullet.set_collision_layer_value(2, 0)
	bullet.set_collision_layer_value(5, 1)
	get_tree().root.add_child(bullet)
	bullet.position = global_position
	bullet.direction = get_random_dir()
	
func get_random_dir():
	var node_y = get_global_transform().origin.y 
	var screen_height = get_viewport().get_visible_rect().size.y
	var shootDown = node_y <= screen_height/2
	if shootDown:
		var angle = deg_to_rad(randf_range(45, 155))
		return Vector2(cos(angle), sin(angle))
	else:
		var angle = deg_to_rad(randf_range(225, 315))
		return Vector2(cos(angle), sin(angle))

func _on_area_entered(area):
	if area is Bullet:
		queue_free()
		area.queue_free()
		destruction_particles.emitting = true
		destruction_particles.reparent(get_tree().root)
