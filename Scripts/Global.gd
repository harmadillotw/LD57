extends Node

var columns = 5
var rows = 25
var tileDictionary : Dictionary[int,Node2D]
#var tileResourceDictionary : Dictionary[int,TileStats]
var tileStatsDictionary : Dictionary[int,TileStats]
var tileCount = 0

var events = []

var player

var gameSeed := 0
