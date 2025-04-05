extends Area2D

signal tileArea_clicked

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left click"):
		print("clicked on sprite")
		tileArea_clicked.emit()
