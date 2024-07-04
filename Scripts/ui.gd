extends CanvasLayer

var life_texture = preload("res://Assets/Sprites/lives.png")
var death_texture = preload("res://Assets/Sprites/player.png")

@onready var LivesContainer = $MarginContainer/LivesContaier
@onready var LivesManager = get_parent().get_child(4)
@onready var GameOverLabel = $MarginContainer2/VBoxContainer/GameOverLabel
@onready var PlaytimeLabel = $MarginContainer2/VBoxContainer/PlayTime
@onready var ScoreLabel = $MarginContainer/ScoreContainer/Score
var playtime = 0 

func _process(delta):
	playtime += delta

func _ready():
	var count = LivesManager.lives
	for i in range(count):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		life_texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		life_texture_rect.texture = life_texture
		life_texture_rect.custom_minimum_size = Vector2(42, 42)
		LivesContainer.add_child(life_texture_rect)

func _on_lives_manager_player_death(lives_left):
	var life_texture_rect : TextureRect = LivesContainer.get_child(lives_left)
	life_texture_rect.texture = death_texture
	if lives_left==0:
		GameOverLabel.visible = true
		playtime = snapped(playtime, 0.01)
		PlaytimeLabel.text = "Playtime: " + str(playtime)
		PlaytimeLabel.visible = true
		get_tree().paused = true

func _on_asteroid_spawner_update_points(points):
	ScoreLabel.text = str(points)

func _on_asteroid_spawner_game_won():
	GameOverLabel.text = "You Won!"
	GameOverLabel.visible= true
	playtime = snapped(playtime, 0.01)
	PlaytimeLabel.text = "Playtime: " + str(playtime)
	PlaytimeLabel.visible = true
	get_tree().paused = true
