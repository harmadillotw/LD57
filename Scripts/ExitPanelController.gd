extends Node2D


func _on_cancel_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	self.set_visible(false)


func _on_exit_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
