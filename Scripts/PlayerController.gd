extends Node2D

@export var location_id = 0

var gridWidth = 140
var gridHeight = 88
var gridWSpace = 5
var gridHSpace = 5
@export var torches = 5
@export var light = 5

func updatePosition():
	var i = location_id/5
	var j = location_id % 5
	var xLoc = 70 + ((gridWidth + gridWSpace) * j);
	var yLoc = 44 + ((gridHeight + gridHSpace) * i);
	position = Vector2(xLoc,yLoc)	
