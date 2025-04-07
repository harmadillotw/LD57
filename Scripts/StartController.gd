extends Node2D

@onready var lineEdit: LineEdit = $Panel/LineEdit


func _ready() -> void:
	var randSeed = randi() % 1000000
	lineEdit.text = str(randSeed)
	Global.gameSeed = randSeed

func _on_start_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_seed_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	var randSeed = randi() % 1000000
	lineEdit.text = str(randSeed)
	Global.gameSeed = randSeed
	


func _on_return_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
