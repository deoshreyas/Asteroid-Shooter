extends Area2D
class_name Bullet

var direction : Vector2 

@export var speed = 700.0

func _process(delta):
	position += speed * direction * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is PlayerShip and self.is_in_group("UFOBullet") and !(body as PlayerShip).isImmune:
		(body as PlayerShip).player_died.emit()
		body.queue_free()
		queue_free()
