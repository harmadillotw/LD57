extends Node2D


func _on_start_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")


func _on_options_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/Options.tscn")


func _on_exit_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().quit()
