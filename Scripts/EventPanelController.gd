extends Node2D

@onready var textLabel : RichTextLabel = $Panel/RichTextLabel
@onready var button1 : Button = $Panel/Button1
@onready var button2 : Button = $Panel/Button2

var event := 0
var descText := ""

signal event_completed()
	
func setText(newText):
	textLabel.text = newText
func populateEvent(newText, eventNum):
	descText = newText + "/n/n" + Global.events[event][9]
	event = eventNum
	button1.text = Global.events[event][7]
	button2.text = Global.events[event][8]
	if Global.events[event][6] == 2:
		button2.set_visible(true)
	else:
		button2.set_visible(false)	
		
func _on_button_pressed() -> void:
	Global.player.health += Global.events[event][0]
	Global.player.torches += Global.events[event][4]
	Global.player.light += Global.events[event][2]
	event_completed.emit()
	self.set_visible(false)
	
func _on_button_2_pressed() -> void:
	
	Global.player.health += Global.events[event][1]
	Global.player.torches += Global.events[event][5]
	Global.player.light += Global.events[event][3]
	event_completed.emit()
	self.set_visible(false)
	
