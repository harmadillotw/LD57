extends Node2D

@export var location_id = 0

var gridWidth = 140
var gridHeight = 88
var gridWSpace = 5
var gridHSpace = 5
@export var rope = 10
@export var torches = 5
@export var light = 4
@export var health = 20
@onready var playerSprite : Sprite2D = $Sprite2D
var textures
func _ready() -> void:
	textures = [load("res://Images/tile_player1.png"),load("res://Images/tile_player2.png"),load("res://Images/tile_player3.png")]
func updatePosition():
	var i = location_id/5
	var j = location_id % 5
	var xLoc = 70 + ((gridWidth + gridWSpace) * j);
	var yLoc = 44 + ((gridHeight + gridHSpace) * i);
	position = Vector2(xLoc,yLoc)	
	playerSprite.texture = textures[randi_range(0,2)]
