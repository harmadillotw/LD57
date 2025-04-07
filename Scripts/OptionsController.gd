extends Node2D

var user_prefs: UserPreferences


func _on_start_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_music_h_slider_value_changed(value: float) -> void:
	Global.musicVolume = value
	
	MasterAudioStreamPlayer.set_volume(value)
	if user_prefs:
		user_prefs.music_volume = value
		user_prefs.save()


func _on_fxh_slider_2_value_changed(value: float) -> void:
	Global.fxVolume = value
	
	if user_prefs:
		user_prefs.fx_volume = value
		user_prefs.save()
