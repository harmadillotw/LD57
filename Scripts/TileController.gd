extends Node2D

@export var id : int
#@export var stats: TileStats = preload("res://Resources/TileStats.tres")
@export var explored : bool
@export var searched : bool

@onready var rightSprite : Sprite2D = $Explored2D/SpriteRight
@onready var leftSprite : Sprite2D = $Explored2D/SpriteLeft

var right_textures
var left_textures
var bottom_textures
var top_textures

var tr_textures
var tl_textures
var br_textures
var bl_textures

signal tile_clicked(id)

func _ready():	
	#stats = load("res://Resources/TileStats.tres")
	get_node("Area2D").tileArea_clicked.connect(_on_Emitter_tileArea_clicked)

func set_id(p_id):
	id = p_id
	right_textures = [load("res://Images/tile_right1.png"),load("res://Images/tile_right2.png"),load("res://Images/tile_right3.png")]
	left_textures = [load("res://Images/tile_left1.png"),load("res://Images/tile_left2.png"),load("res://Images/tile_left3.png")]
	bottom_textures = [load("res://Images/tile_bottom1.png"),load("res://Images/tile_bottom2.png"),load("res://Images/tile_bottom3.png")]
	top_textures = [load("res://Images/tile_top1.png"),load("res://Images/tile_top2.png"),load("res://Images/tile_top3.png")]
	
	tr_textures = [load("res://Images/tile_tr1.png"),load("res://Images/tile_tr2.png"),load("res://Images/tile_tr3.png")]
	tl_textures = [load("res://Images/tile_tl1.png"),load("res://Images/tile_tl2.png"),load("res://Images/tile_tl3.png")]
	br_textures = [load("res://Images/tile_br1.png"),load("res://Images/tile_br2.png"),load("res://Images/tile_br3.png")]
	bl_textures = [load("res://Images/tile_bl1.png"),load("res://Images/tile_bl2.png"),load("res://Images/tile_bl3.png")]
	var tileStats = Global.tileStatsDictionary[id]
	get_node("Explored2D/SpriteRight").texture = right_textures[tileStats.Tright]
	get_node("Explored2D/SpriteLeft").texture = left_textures[tileStats.Tleft]
	get_node("Explored2D/SpriteTop").texture = top_textures[tileStats.Ttop]
	get_node("Explored2D/SpriteBottom").texture = bottom_textures[tileStats.Tbottom]
	
	get_node("Explored2D/SpriteTR").texture = tr_textures[tileStats.Ttr]
	get_node("Explored2D/SpriteTL").texture = tl_textures[tileStats.Ttl]
	get_node("Explored2D/SpriteBR").texture = br_textures[tileStats.Tbr]
	get_node("Explored2D/SpriteBL").texture = bl_textures[tileStats.Tbl]
	
func _on_Emitter_tileArea_clicked():
	print("clicked on sprite %d" % id)
	tile_clicked.emit(id)
	
func setRight(show):
	get_node("Explored2D/SpriteRight").set_visible(show)
	get_node("Explored2D/SpriteRightClosed").set_visible(!show)	
func setRightClosed(show):
	get_node("Explored2D/SpriteRightClosed").set_visible(show)	
func setLeft(show):
	get_node("Explored2D/SpriteLeft").set_visible(show)
	get_node("Explored2D/SpriteLeftClosed").set_visible(!show)
func setLeftClosed(show):
	get_node("Explored2D/SpriteLeftClosed").set_visible(show)	
func setTop(id):
	var tileStats = Global.tileStatsDictionary[id]
	get_node("Explored2D/SpriteTop").set_visible(tileStats.topE)
	get_node("Explored2D/SpriteTopSlope").set_visible(tileStats.topSlope)
	var open = tileStats.topE || tileStats.topSlope
	get_node("Explored2D/SpriteTopClosed").set_visible(!open)	

func setRopes(show):
	get_node("Explored2D/SpriteRopes").set_visible(show)
		
func setBottom(id):
	var tileStats = Global.tileStatsDictionary[id]
	get_node("Explored2D/SpriteBottom").set_visible(tileStats.bottomE)
	get_node("Explored2D/SpriteBottomSlope").set_visible(tileStats.bottomSlope)	
	var open = tileStats.bottomE || tileStats.bottomSlope
	get_node("Explored2D/SpriteBottomClosed").set_visible(!open)	
		
#func setBottomSlope(show):
#	get_node("Explored2D/SpriteBottomSlope").set_visible(show)	
	
#func setBottomClosed(show):
#	get_node("Explored2D/SpriteBottomClosed").set_visible(show)	
	
func setHighlight(show):
	#get_node("Explored2D/SpriteHighlight").set_visible(show)	
	get_node("SpriteHighlight").set_visible(show)
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
	
func setBio1(show):
	get_node("Explored2D/SpriteBio1").set_visible(show)	
func setBio2(show):
	get_node("Explored2D/SpriteBio2").set_visible(show)	
func setLake(show):
	get_node("Explored2D/SpriteLake").set_visible(show)	
func setRiver(show):
	get_node("Explored2D/SpriteRiver").set_visible(show)	
func setCrev(show):
	get_node("Explored2D/SpriteCrevasse").set_visible(show)	
func setPaint(show):
	get_node("Explored2D/SpritePaint").set_visible(show)	
func setVines(show):
	get_node("Explored2D/SpriteVines").set_visible(show)	
func setSlime(show):
	get_node("Explored2D/SpriteSlime").set_visible(show)
