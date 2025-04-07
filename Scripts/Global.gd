extends Node

var musicVolume = 0.0
var fxVolume = 0.0

var columns = 5
var rows = 25
var tileDictionary : Dictionary[int,Node2D]
#var tileResourceDictionary : Dictionary[int,TileStats]
var tileStatsDictionary : Dictionary[int,TileStats]
var tileCount = 0

var events = []

var player

var gameSeed := 0

var levelStat := 0
var torchStat := 0
var exploredStat := 0
var encounterStat := 0
var mapStat := 0
var ropeStat := 0
var bearStat := 0

var failReason := 0
