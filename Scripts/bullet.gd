extends Area2D
class_name Bullet

var direction : Vector2 

@export var speed = 700.0

func _process(delta):
	position += speed * direction * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
