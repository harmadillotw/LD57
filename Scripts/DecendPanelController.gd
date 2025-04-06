extends Node2D

@onready var textLabel : RichTextLabel = $Panel/RichTextLabel
@onready var button1 : Button = $Panel/Button
@onready var button2 : Button = $Panel/Button2

var state = 1
var chance = 95
var healthLoss = 0
var lightLoss = 0
const descText = "The descent before you looks near vertical. The way looks treacherous but the walls are rough and you can see possible hand holds. Free climbing will be slow and dangerous but it is possible. You look around and find suitable anchor points for ropes that could aid your climb.
\nShould you use ropes to safely descend or risk it and free climb?"

const successText =	"You successfully negotiate the descent but your torch has burned noticeably lower"	
const failureText =	"A hand hold gives way and you fall to the floor below."
signal decend_completed()

func setup():
	state = 1
	textLabel.text = descText
	button1.set_visible(true)
	chance = randi_range(25,95)
	button1.text = "Free climb (" + str(chance) + "%)"  
	button2.set_visible(true)
	button2.text = "Rappel down (1 rope)"
	if Global.player.rope > 0:
		button1.disabled = false
	else:
		button1.disabled = true

## decend with rope
func _on_button_pressed() -> void:
	if state == 1 :
		button2.set_visible(false)
		if randi_range(1,100) > chance:
			healthLoss = randi_range(1,3)
			Global.player.health -= healthLoss
			
			button1.text = "Continue"
			textLabel.text = failureText
			state = 2
		else:
			lightLoss = randi_range(1,2)
			Global.player.light -= lightLoss
			textLabel.text = successText
			button1.text = "Continue"
			state = 2
	else:
		decend_completed.emit()
		self.set_visible(false)

func _on_button_2_pressed() -> void:
	Global.player.rope -= 1
	decend_completed.emit()
	self.set_visible(false)
	
