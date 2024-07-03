extends Marker2D

@export var bullet : PackedScene

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var bullet_shot = bullet.instantiate() as Bullet 
		get_tree().root.add_child(bullet_shot)
		bullet_shot.direction = Vector2(0, 1).rotated(get_parent().rotation)
		bullet_shot.position = global_position
