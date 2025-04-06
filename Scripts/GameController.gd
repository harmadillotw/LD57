extends Node2D

var tileGridScene = preload("res://Scenes/TileGrid.tscn")

@onready var exploreButton: Button = $Camera2D/ExploreButton
@onready var searchButton: Button = $Camera2D/SearchButton
@onready var moveButton: Button =  $Camera2D/MoveButton
@onready var camera: Camera2D = $Camera2D

@onready var lightLabel: Label = $Camera2D/LightLabel
@onready var torchLabel: Label = $Camera2D/TorchLabel
@onready var healthLabel: Label = $Camera2D/HealthLabel
@onready var descriptionLabel : RichTextLabel = $Camera2D/DescriptionLabel

@onready var eventLabel: Node2D = $Camera2D/EventPanel
@onready var descendLabel: Node2D = $Camera2D/DescendPanel


var previousPlayerTileId
var playerTileId
var selectedTile
var selectedTileStat


func _ready() -> void:
	populateEvents()
	initialiseGrid()
	var instance = tileGridScene.instantiate()
	instance.populate()
	instance.position = Vector2(10,10)
	instance.tile_selected.connect(_on_Emitter_tile_selected)
	eventLabel.event_completed.connect(_on_Event_Complete)
	descendLabel.decend_completed.connect(_on_Event_Complete)
	add_child(instance)
	updateStatus()
	_on_Emitter_tile_selected(0)
	previousPlayerTileId = 0
	playerTileId = 0
	clearAccessible(0)
	setAccessible(0)
	updateDescription()

func _on_Emitter_tile_selected(id):
	selectedTile = Global.tileDictionary[id]
	selectedTileStat = Global.tileStatsDictionary[id]
	updateDescription()
	updateUI()
	
func _on_Event_Complete():
	updateStatus()
	
func updateUI():
	#exploreButton.set_visible(false)
	exploreButton.disabled = true
	#searchButton.set_visible(false)
	searchButton.disabled = true
	#moveButton.set_visible(false)
	moveButton.disabled = true
	if (selectedTileStat.reachable):
		if (Global.player.location_id == selectedTile.id):
			if (selectedTile.explored) && (!selectedTile.searched):
				#searchButton.set_visible(true)
				searchButton.disabled = false
		if !selectedTile.explored && selectedTileStat.accessible:
			#exploreButton.set_visible(true)
			exploreButton.disabled = false
		if ((selectedTile.explored) && Global.player.location_id != selectedTile.id) && selectedTileStat.accessible:
			#moveButton.set_visible(true)
			moveButton.disabled = false

func clearAccessible(id):
	if (id > 0):
		Global.tileStatsDictionary[id-1].accessible = false
		if !Global.tileStatsDictionary[id-1].explored:
			Global.tileDictionary[id-1].setUnexplored(true)
	if (id > Global.columns):
		Global.tileStatsDictionary[id-Global.columns].accessible = false
		if !Global.tileStatsDictionary[id-Global.columns].explored:
			Global.tileDictionary[id-Global.columns].setUnexplored(true)
	if (id < Global.columns * Global.rows):
		Global.tileStatsDictionary[id+1].accessible = false
		if !Global.tileStatsDictionary[id+1].explored:
			Global.tileDictionary[id+1].setUnexplored(true)
	if ( id < ( Global.columns * (Global.rows -1))):
		Global.tileStatsDictionary[id+Global.columns].accessible = false
		if !Global.tileStatsDictionary[id+Global.columns].explored:
			Global.tileDictionary[id+Global.columns].setUnexplored(true)	
func setAccessible(id):	
	if (id > 0) && Global.tileStatsDictionary[id].leftE:
		Global.tileStatsDictionary[id-1].accessible = true
		if !Global.tileStatsDictionary[id-1].explored:
			Global.tileDictionary[id-1].setAccessible(true)
	if (id > Global.columns) && Global.tileStatsDictionary[id].topE:
		Global.tileStatsDictionary[id-Global.columns].accessible = true
		if !Global.tileStatsDictionary[id-Global.columns].explored:
			Global.tileDictionary[id-Global.columns].setAccessible(true)
	if (id < Global.columns * Global.rows) && Global.tileStatsDictionary[id].rightE:
		Global.tileStatsDictionary[id+1].accessible = true
		if !Global.tileStatsDictionary[id+1].explored:
			Global.tileDictionary[id+1].setAccessible(true)
	if ( id < ( Global.columns * (Global.rows -1)))&& Global.tileStatsDictionary[id].bottomE:
		Global.tileStatsDictionary[id+Global.columns].accessible = true	
		if !Global.tileStatsDictionary[id+Global.columns].explored:
			Global.tileDictionary[id+Global.columns].setAccessible(true)
		
func _on_explore_button_pressed() -> void:
	if selectedTile:
		var doDescent = false
		if (Global.player.location_id > Global.columns) && (Global.player.location_id == (selectedTile.id - Global.columns)):
			if (Global.tileStatsDictionary[Global.player.location_id].bottomE):
				doDescent = true
		Global.tileStatsDictionary[selectedTile.id].explored = true
		var description = Global.tileStatsDictionary[selectedTile.id].description
		if 	doDescent:
			descendLabel.setup()
			descendLabel.set_visible(true)
		else:
			var displayText = Events.Descriptions[description]
			eventLabel.populateEvent(displayText,Global.tileStatsDictionary[selectedTile.id].event)
			#eventLabel.setText(displayText)
			eventLabel.set_visible(true)
		
		updateDescription()
		selectedTile.exploreTile()
		
		updateDescription()
		movePlayer()
		updateUI()


func _on_search_button_pressed() -> void:
	Global.tileStatsDictionary[selectedTile.id].searched = true
	selectedTile.setSearched(true)
	updateLight()
	updateUI()


func _on_move_button_pressed() -> void:
	if (Global.player.location_id != selectedTile.id):
		movePlayer()
		updateDescription()

func movePlayer():
		Global.player.location_id = selectedTile.id
		previousPlayerTileId = playerTileId
		playerTileId = selectedTile.id
		Global.player.updatePosition()
		clearAccessible(previousPlayerTileId)
		setAccessible(playerTileId)
		updateLight()
		
func _input(event):
	if event.is_action_pressed("camera_up"):
		var newY = camera.position.y-90
		if (newY < 300 ):
			newY = 300
		camera.position = Vector2(camera.position.x,newY)
	if event.is_action_pressed("camera_down"):
		var newY = camera.position.y+90
		var maxY = (Global.rows * 90)
		if (newY > maxY ):
			newY = maxY
		camera.position = Vector2(camera.position.x,newY)

func updateDescription():
	if Global.tileStatsDictionary[selectedTile.id].explored:
		var description = Global.tileStatsDictionary[selectedTile.id].description
		var displayText = Events.Descriptions[description]
		descriptionLabel.text = displayText
	else:
		descriptionLabel.text = "Unexplored"
		
func updateLight():
	Global.player.light -= 1
	if Global.player.light == 0:
		Global.player.torches -= 1
		Global.player.light = 5
	updateStatus()
func updateStatus():
	if Global.player:
		lightLabel.text = "Light: " + str(Global.player.light)
		torchLabel.text = "Torches: " + str(Global.player.torches)
		healthLabel.text = "Health: " + str(Global.player.health)
	if Global.player.torches == 0:
		pass
		#End game
### initialise grid ###
func initialiseGrid():
	var rng = RandomNumberGenerator.new()
	var randSeed = randi() % 1000000
	#randSeed = 96282
	print(" Seed is %d " % randSeed)
	rng.seed = randSeed
	var id=0
	var preMaxCol = 3
	var preMinCol = 3
	for i in Global.rows:
		var downs 
		var downSlopes 
		var minColumns = 5
		var minCol = -1
		var maxCol = -1
		var downCols = []
		var downSlopeCols = []
		if (i >= 0) && (i <= 5):
			
			
			minColumns = 5			
			downs = rng.randi_range(2,4)
			downSlopes = rng.randi_range(2,downs)
			downs = downs - downSlopes
			
				
		elif (i >= 5) && (i <= 10):
			minColumns = 5
			downs = rng.randi_range(2,3)
			downSlopes = rng.randi_range(2,downs)
			downs = downs - downSlopes
		elif (i >= 10) && (i <= 15):
			minColumns = 4
			downs = rng.randi_range(1,3)
			downSlopes = rng.randi_range(1,downs)
			downs = downs - downSlopes
		elif (i >= 15) && (i <= 20):
			minColumns = 3
			downs = rng.randi_range(1,3)
			downSlopes = rng.randi_range(1,downs)
			downs = downs - downSlopes
		elif (i == (Global.rows -1)):
			downs = 0
			downSlopes = 0
			minColumns = 0
		else:
			minColumns = 3
			downs = rng.randi_range(1,2)
			downSlopes = rng.randi_range(0,downs)
			downs = downs - downSlopes
		var availableCols = [0,1,2,3,4]
		for n in downs:
			var size = availableCols.size() - 1
			var col = availableCols.pop_at(rng.randi_range(0,size))
			if (minCol == -1):
				minCol = col
			if (col < minCol):
				minCol = col
			if (maxCol == -1):
				maxCol = col
			if (col > maxCol):
				maxCol = col
			downCols.push_back(col)
		for n in downSlopes:
			var size = availableCols.size() - 1
			var col = availableCols.pop_at(rng.randi_range(0,size))
			
			if (minCol == -1):
				minCol = col
			if (col < minCol):
				minCol = col
			if (maxCol == -1):
				maxCol = col
			if (col > maxCol):
				maxCol = col
			downSlopeCols.push_back(col)
		var saveMinCol = minCol
		var saveMaxCol = maxCol
		if (i > 0):
			print("MinCol %d MaxCol %d" % [preMinCol,preMaxCol])
			if (minCol > preMinCol):
				minCol = preMinCol
			if (maxCol < preMaxCol):
				maxCol = preMaxCol
		for m in 2:
			var numCols = rng.randi_range(minColumns,Global.columns +1)
			if (maxCol-minCol +1) < numCols:
				if (rng.randi_range(1,2) == 1):
					if (minCol > 0):
						minCol -= 1
					else:
						maxCol += 1
				else:
					if (maxCol < Global.columns):
						maxCol += 1
					else:
						minCol -= 1
		if (i > 0):
			preMinCol = saveMinCol
			preMaxCol = saveMaxCol
		for j in Global.columns:
			var newTileStat = TileStats.new()
			
			if (j >= minCol) && ( j <= maxCol):
				newTileStat.reachable = true
				#var newTileStat = TileStats.new()
				newTileStat.id = id
				newTileStat.explored = false
				newTileStat.searched = false
				if (id ==0):
					newTileStat.explored = true
					newTileStat.searched = true
					newTileStat.rightE = true
				elif (id ==1):
					newTileStat.leftE = true
					newTileStat.rightE = true
				elif (id ==2):
					newTileStat.leftE = true
					newTileStat.rightE = true
				elif (id ==3):
					newTileStat.rightE = true
					newTileStat.leftE = true
					newTileStat.bottomE = true
				elif (id ==4):
					newTileStat.explored = false
					newTileStat.leftE = true
				else:
					
					if(downSlopeCols.has(j) == true):
						newTileStat.bottomE = true
						#newTileStat.leftE = true
					if(downCols.has(j)== true):
						newTileStat.bottomE = true

			else:
				
				newTileStat.id = id
				newTileStat.explored = false
				newTileStat.searched = false
				if (id ==0):
					newTileStat.explored = true
					newTileStat.searched = true
					newTileStat.rightE = true
				elif (id ==1):
					newTileStat.leftE = true
					newTileStat.rightE = true
				elif (id ==2):
					newTileStat.leftE = true
					newTileStat.rightE = true
				elif (id ==3):
					newTileStat.rightE = true
					newTileStat.leftE = true
					newTileStat.bottomE = true
				elif (id ==4):
					newTileStat.explored = false
					newTileStat.leftE = true
			## assign descriptions
			if (id ==0):
				newTileStat.description = 0
			if (id ==1):
				newTileStat.description = 1
			if (id ==2):
				newTileStat.description = 1
			else:
				var rolled = rng.randi_range(1,100)
				if (i > 20):
					match rolled:
						1,2,3,4,5,6,7,8,9,10:
							newTileStat.description = 1
						11,12,13,14,15,16,17,18,19,20:
							newTileStat.description = 1
						21,22,23,24,25:
							newTileStat.description = 2
						31,32,33,34,35,36,37,38,39,40:
							newTileStat.description = 1
						41,42,43,44,45,46,47,48,49,50:
							newTileStat.description = 1
						51,52,53,54,55:
							newTileStat.description = 5
						56,57,58,59,60:
							newTileStat.description = 6
						61,62,63,64,65:
							newTileStat.description = 7
						66,67,68,69,70:
							newTileStat.description = 8
						71,72,73,74,75:
							newTileStat.description = 9
						76,77,78,79,80:
							newTileStat.description = 10
						81,82,83,84,85:
							newTileStat.description = 11
						86,87,88,89,90:
							newTileStat.description = 12
						91,92,93,94,95:
							newTileStat.description = 13
						96,97,98,99,100:
							newTileStat.description = 14
				elif (i > 30):
					match rolled:
						1,2,3,4,5,6,7,8,9,10:
							newTileStat.description = 3
						11,12,13,14,15,16,17,18,19,20:
							newTileStat.description = 3
						21,22,23,24,25:
							newTileStat.description = 4
						31,32,33,34,35,36,37,38,39,40:
							newTileStat.description = 4
						41,42,43,44,45,46,47,48,49,50:
							newTileStat.description = 3
						51,52,53,54,55:
							newTileStat.description = 5
						56,57,58,59,60:
							newTileStat.description = 6
						61,62,63,64,65:
							newTileStat.description = 7
						66,67,68,69,70:
							newTileStat.description = 8
						71,72,73,74,75:
							newTileStat.description = 9
						76,77,78,79,80:
							newTileStat.description = 10
						81,82,83,84,85:
							newTileStat.description = 11
						86,87,88,89,90:
							newTileStat.description = 12
						91,92,93,94,95:
							newTileStat.description = 13
						96,97,98,99,100:
							newTileStat.description = 14
				else:
					match rolled:
						1,2,3,4,5,6,7,8,9,10:
							newTileStat.description = 1
						11,12,13,14,15,16,17,18,19,20:
							newTileStat.description = 2
						21,22,23,24,25:
							newTileStat.description = 3
						31,32,33,34,35,36,37,38,39,40:
							newTileStat.description = 4
						41,42,43,44,45,46,47,48,49,50:
							newTileStat.description = 1
						51,52,53,54,55:
							newTileStat.description = 5
						56,57,58,59,60:
							newTileStat.description = 6
						61,62,63,64,65:
							newTileStat.description = 7
						66,67,68,69,70:
							newTileStat.description = 8
						71,72,73,74,75:
							newTileStat.description = 9
						76,77,78,79,80:
							newTileStat.description = 10
						81,82,83,84,85:
							newTileStat.description = 11
						86,87,88,89,90:
							newTileStat.description = 12
						91,92,93,94,95:
							newTileStat.description = 13
						96,97,98,99,100:
							newTileStat.description = 14
			## assign events
			newTileStat.event = 13
			Global.tileStatsDictionary[id] = newTileStat
			id += 1	
	id=0
	for i in Global.rows:
		for j in Global.columns:
			if i > 0:
				if (Global.tileStatsDictionary[id].reachable):
					if (j > 0) && Global.tileStatsDictionary[id-1].reachable:
						Global.tileStatsDictionary[id].leftE = true
					if (j < (Global.columns - 1)) && Global.tileStatsDictionary[id+1].reachable:
						Global.tileStatsDictionary[id].rightE = true
					if (Global.tileStatsDictionary[id-Global.columns].bottomE):
						Global.tileStatsDictionary[id].topE = true
					if (Global.tileStatsDictionary[id-Global.columns].bottomSlope):
						Global.tileStatsDictionary[id].topSlope = true
			id += 1	
			
func populateEvents():
	for n in Events.numEvents:
		Global.events.push_back([Events.EventH1[n], Events.EventH2[n], Events.EventL1[n],
						Events.EventL2[n],Events.EventT1[n],Events.EventT2[n],Events.EventOptions[n],
						Events.EventOpt1[n], Events.EventOpt2[n], Events.EventDesc[n]])


	
