extends Node

const STAR_SCENE = preload("res://Stars.tscn")
const STAR_SPAWN_Y = -16

var screenWidth
var screenHeight

onready var starsWrapper = $Stars


func _ready():
	screenWidth = ProjectSettings.get("display/window/size/width")
	screenHeight = ProjectSettings.get("display/window/size/height")
	for i in 15:
		spawnStar(Vector2(randi() % screenWidth, randi() % screenHeight))
		
		
func spawnStar(pos):
	var inst = STAR_SCENE.instance()
	inst.position = pos
	starsWrapper.add_child(inst)


func _on_StarSpawn_timeout():
	spawnStar(Vector2(randi() % screenWidth, STAR_SPAWN_Y))
