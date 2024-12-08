extends Control

@onready var pause_menu := $"."
@onready var settings_menu := $"../Settings Menu"

func _on_resume_pressed():
	pause_menu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Engine.time_scale = 1


func _on_settings_pressed():
	pause_menu.hide()
	settings_menu.show()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Main Menu.tscn")


func _on_quit_game_pressed():
	get_tree().quit()
