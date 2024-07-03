extends CharacterBody2D
class_name PlayerShip 

@export var max_vel = 10.0 
@export var rotation_speed = 3.5 
@export var velocity_limiting = 0.3 
@export var linear_velocity = 200

var input_vector : Vector2
var rotation_dir : int

func _process(_delta):
	input_vector.x = Input.get_action_strength("go_left") - Input.get_action_strength("go_right")
	input_vector.y = Input.get_action_strength("move")
	if Input.is_action_pressed("go_left"):
		rotation_dir = -1 
	elif Input.is_action_pressed("go_right"):
		rotation_dir = 1
	else:
		rotation_dir = 0 

func _physics_process(delta):
	rotation += rotation_dir * rotation_speed * delta
	if input_vector.y > 0:
		accelerate_forward(delta)
	elif input_vector.y==0 and velocity!=Vector2.ZERO:
		slow_down(delta)
	limit_movement()
	move_and_collide(velocity * delta)

func accelerate_forward(delta):
	velocity += (input_vector * linear_velocity * delta).rotated(rotation)
	velocity.limit_length(max_vel)

func slow_down(delta):
	velocity = lerp(velocity, Vector2.ZERO, velocity_limiting*delta)
	if velocity.y >= -0.1 and velocity.y <= 0.1:
		velocity.y = 0
		
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
	
