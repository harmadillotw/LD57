extends Node2D

@onready var textLabel : RichTextLabel = $Panel/Panel/Panel/RichTextLabel
@onready var button1 : Button = $Panel/Button1
@onready var button2 : Button = $Panel/Button2

var event := 0
var descText := ""
var button1Pct = 0
var button2Pct = 0
var b1State = 0
var b2State = 0
var descriptionText
signal event_completed()
	
func setText(newText):
	textLabel.text = newText
	
func populateEvent(newText, eventNum):
	event = eventNum
	descriptionText = newText
	descText = descriptionText + "\n\n" + Events.EventDesc[event]
	textLabel.text = descText
	
	button1Pct = 0
	button2Pct = 0
	b1State = 0
	b2State = 0
	var button1Text = Events.EventOpt1[eventNum]
	if Events.Percent1[eventNum] >0:
		button1Pct = randi_range(1,100)
		button1Text += " " + str(button1Pct) + "%"
		b1State = 1
	var button2Text = Events.EventOpt2[eventNum]
	if Events.Percent2[eventNum] >0:
		button2Pct = randi_range(1,100)
		button2Text += " " + str(button2Pct) + "%"
		b2State = 1
	if Events.EventOptions[eventNum] > 1:
		button2.set_visible(true)
	else:
		button2.set_visible(false)
	button1.text = button1Text
	button2.text = button2Text
		
func _on_button_pressed() -> void:
	#Global.player.health += Global.events[event][0]
	#Global.player.torches += Global.events[event][4]
	#Global.player.light += Global.events[event][2]
	if b1State == 0:
		Global.player.health += Events.EventH1[event]
		Global.player.torches += Events.EventT1[event]
		Global.player.light += Events.EventL1[event]
		event_completed.emit()
		self.set_visible(false)
	elif b1State == 1:
		var rolled = randi_range(1,100)
		if rolled < button1Pct:
			descText = descriptionText + "\n\n" + Events.SResult1[event]
			textLabel.text = descText
			button1.text = "Continue"
		else:
			descText = descriptionText + "\n\n" + Events.FResult1[event]
			textLabel.text = descText
			button1.text = "Continue"
			Global.player.health += Events.EventH1[event]
			Global.player.torches += Events.EventT1[event]
			Global.player.light += Events.EventL1[event]
		button2.set_visible(false)
		b1State = 2
	elif b1State == 2:	
		event_completed.emit()
		self.set_visible(false)
	
func _on_button_2_pressed() -> void:
	
	#Global.player.health += Global.events[event][1]
	#Global.player.torches += Global.events[event][5]
	#Global.player.light += Global.events[event][3]
	Global.player.health += Events.EventH2[event]
	Global.player.torches += Events.EventT2[event]
	Global.player.light += Events.EventL2[event]
	if b2State == 0:
		Global.player.health += Events.EventH2[event]
		Global.player.torches += Events.EventT2[event]
		Global.player.light += Events.EventL2[event]
		event_completed.emit()
		self.set_visible(false)
	elif b2State == 1:
		var rolled = randi_range(1,100)
		if rolled < button2Pct:
			descText = descriptionText + "\n\n" + Events.SResult2[event]
			textLabel.text = descText
			button1.text = "Continue"
		else:
			descText = descriptionText + "\n\n" + Events.FResult2[event]
			textLabel.text = descText
			button1.text = "Continue"
			Global.player.health += Events.EventH2[event]
			Global.player.torches += Events.EventT2[event]
			Global.player.light += Events.EventL2[event]
		button2.set_visible(false)
		b1State = 2
	elif b2State == 2:	
		event_completed.emit()
		self.set_visible(false)
	
