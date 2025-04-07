extends Node2D

@onready var seedLabel: Label = $Panel/SeedLabel
@onready var textLabel : RichTextLabel = $Panel/Panel/Panel/RichTextLabel

func _ready() -> void:
	seedLabel.text = "#" + str(Global.gameSeed)
	var statsText = "Game Stats"
	statsText += "\n\nLevels Descended: " + str(Global.levelStat)
	statsText += "\nCaverns Explored: " + str(Global.exploredStat)
	statsText += "\nTorches Used: " + str(Global.torchStat)
	statsText += "\nTimes Rappelled: " + str(Global.ropeStat)
	statsText += "\nEncounters Sampled: " + str(Global.encounterStat)
	statsText += "\nMap Additions: " + str(Global.mapStat)
	statsText += "\nBears Encountered: " + str(Global.bearStat)
	textLabel.text = statsText
	
func _on_main_menu_button_pressed() -> void:
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
