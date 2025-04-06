extends Node2D

var tileScene = preload("res://Scenes/Tile.tscn")
var playerScene = preload("res://Scenes/Player.tscn")
var tileDictionary = {}
var gridWidth = 140
var gridHeight = 88
var gridWSpace = 5
var gridHSpace = 5
var player

signal tile_selected(id)

func populate():
	print("populating grid")
	var id = 0
	
	for i in Global.rows:
		for j in Global.columns:
			var tileStats = Global.tileStatsDictionary[id]
			var instance = tileScene.instantiate()
			var xLoc = 70 + ((gridWidth + gridWSpace) * j);
			var yLoc = 44 + ((gridHeight + gridHSpace) * i);
			var startLocation = Vector2(xLoc,yLoc)
			instance.position = startLocation
			instance.id =id
			instance.tile_clicked.connect(_on_Emitter_tile_clicked)
			#instance.set_id(id)
			instance.setExplored(tileStats.explored)
			instance.setSearched(tileStats.searched)
			instance.setLeft(tileStats.leftE)
			instance.setRight(tileStats.rightE)
			instance.setBottom(id)
			instance.setTop(id)
			add_child(instance)
			instance.set_id(id)
			Global.tileDictionary[id] = instance
			id += 1
			Global.tileCount += 1
	player = playerScene.instantiate()
	player.position = Vector2(70,44)
	Global.player = player
	add_child(player)
	
	
func _on_Emitter_tile_clicked(id):
	
	print("clicked on sprite %d" % id)
	var currentTile = Global.tileDictionary[id]
	for i in Global.tileCount:
		Global.tileDictionary[i].setHighlight(false)
	currentTile.setHighlight(true)
	print("id %d, explored %s , searched %s " % [currentTile.id, currentTile.explored, currentTile.searched] )
	tile_selected.emit(id)
	
