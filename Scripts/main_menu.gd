extends Control

var muted = false

func _ready():
	$VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
func _on_music_pressed():
	if muted:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		muted = false
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		muted = true

func _on_quit_pressed():
	get_tree().quit()
