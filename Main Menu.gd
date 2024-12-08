extends Control



func _on_play_pressed():
	if Engine.time_scale != 1:
		Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Level.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Settings Menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
