extends Control

@onready var settings_menu = $"."

func _on_back_pressed():
	var pause_menu = $"../Pause Menu"
	if pause_menu != null:
		settings_menu.hide()
		pause_menu.show()
	else:
		get_tree().change_scene_to_file("res://Main Menu.tscn")
