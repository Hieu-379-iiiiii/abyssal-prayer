extends Node

func _on_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Maps/Lobby.tscn")
	SceneLoader.load_scene("res://Scenes/Maps/Lobby.tscn")

func _on_setting_pressed() -> void:
	pass 


func _on_quit_pressed() -> void:
	get_tree().quit()
