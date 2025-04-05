extends Node2D

@export var id : int
#@export var stats: TileStats = preload("res://Resources/TileStats.tres")
@export var explored : bool
@export var searched : bool
signal tile_clicked(id)

func _ready():	
	#stats = load("res://Resources/TileStats.tres")
	get_node("Area2D").tileArea_clicked.connect(_on_Emitter_tileArea_clicked)

func set_id(p_id):
	id = p_id
func _on_Emitter_tileArea_clicked():
	print("clicked on sprite %d" % id)
	tile_clicked.emit(id)
	
func setRight(show):
	get_node("Explored2D/SpriteRight").set_visible(show)
	
func setLeft(show):
	get_node("Explored2D/SpriteLeft").set_visible(show)
	
func setTop(show):
	get_node("Explored2D/SpriteTop").set_visible(show)
	
func setBottom(show):
	get_node("Explored2D/SpriteBottom").set_visible(show)	
	
func setHighlight(show):
	get_node("Explored2D/SpriteHighlight").set_visible(show)	
	
func setAccessible(show):
	get_node("Explored2D").set_visible(!show)
	get_node("Explored2D/SpriteExplored").set_visible(!show)	
	get_node("SpriteUnexplored").set_visible(!show)	
	get_node("SpriteAccessible").set_visible(show)	

func setUnexplored(show):
	get_node("Explored2D").set_visible(!show)
	get_node("Explored2D/SpriteExplored").set_visible(!show)	
	get_node("SpriteUnexplored").set_visible(show)	
	get_node("SpriteAccessible").set_visible(!show)	
		
func setExplored(show):
	get_node("Explored2D").set_visible(show)
	get_node("Explored2D/SpriteExplored").set_visible(show)	
	get_node("SpriteUnexplored").set_visible(!show)	
	#get_node("SpriteAccessible").set_visible(!show)	
	
	explored = show
func setSearched(show):
	searched = show
	
func exploreTile():
	explored = true
	get_node("Explored2D").set_visible(true)
	get_node("Explored2D/SpriteExplored").set_visible(true)	
	get_node("SpriteUnexplored").set_visible(false)	
	get_node("SpriteAccessible").set_visible(false)	
