extends Node
class_name LivesManager

signal player_death(lives_left: int)

const player_start_pos = Vector2(0, 0)
var lives = 3 

var player_scene = preload("res://Scenes/player_ship.tscn")
@onready var player = get_parent().get_child(1)

func _ready():
	player.player_died.connect(decreaseLives)

func decreaseLives():
	lives -= 1
	player_death.emit(lives)
	if lives!=0:
		var player = player_scene.instantiate() as PlayerShip
		player.player_died.connect(decreaseLives)
		get_tree().root.get_node("World").add_child(player)
		player.global_position = player_start_pos
		player.respawn_immunity()
