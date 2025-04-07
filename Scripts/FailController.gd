extends Node2D

@onready var reasonLabel: Label = $Panel/Label2

func _ready() -> void:
	if Global.failReason == 1:
		reasonLabel.text = "You used all your torches and became lost in the dark."
	else:
		reasonLabel.text = "You ran out of health and died in the dark."
func _on_exit_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
