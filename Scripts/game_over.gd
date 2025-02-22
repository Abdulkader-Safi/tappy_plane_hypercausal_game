extends Control

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
