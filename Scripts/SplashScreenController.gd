extends Node2D

const pre_main_menu = preload("res://Scenes/MainMenu.tscn")

var user_prefs: UserPreferences

func _ready() -> void:
	
	user_prefs = UserPreferences.load_or_create()
	Global.fxVolume = user_prefs.fx_volume
	Global.musicVolume = user_prefs.music_volume
	MasterAudioStreamPlayer.set_volume(Global.musicVolume)
	MasterAudioStreamPlayer.play_music_game()
	
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_packed(pre_main_menu)
