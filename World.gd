extends Node

const STD_POINT_INCREASE = 10
const ENEMY_SCENE = preload("res://Enemy.tscn")
const PLAYER_Y = 666
const ENEMY_Y = -64

var points setget setPoints
var trackPosX = []
var playerTrackPosKey

onready var tracksWrap = $DodgeTracks
onready var player = $Player
onready var enemyWrap = $Enemies
onready var pointsLabel = $UI/BottomContainer/BottomData/HBoxContainer/PointsLabel


func _ready():
	randomize()
	for track in tracksWrap.get_children():
		trackPosX.push_back(track.position.x)
		
	trackPosX.sort()	# in case track nodes ever get out of order
	playerTrackPosKey = ceil(trackPosX.size() / 2)
	player.position = Vector2(trackPosX[playerTrackPosKey], PLAYER_Y)
	player.connect("switch_tracks", self, "_on_Player_switch_track")
	
	self.points = 0
	
	
func movePlayer(dir):
	var newKey = playerTrackPosKey + dir
	if newKey >= 0 && newKey < trackPosX.size():
		playerTrackPosKey = newKey
		player.position = Vector2(trackPosX[playerTrackPosKey], PLAYER_Y)
		
		
func setPoints(val):
	pointsLabel.text = "Points: " + str(val)
	points = val
	
	
func _on_Player_switch_track(dir):
	movePlayer(dir)


func _on_SpawnEnemy_timeout():
	var key = rand_range(0, trackPosX.size() - 1)
	var inst = ENEMY_SCENE.instance()
	inst.position = Vector2(trackPosX[key], ENEMY_Y)
	enemyWrap.add_child(inst)


func _on_LeftControl_pressed():
	movePlayer(-1)


func _on_RightControl_pressed():
	movePlayer(1)


func _on_IncreasePoints_timeout():
	self.points += STD_POINT_INCREASE
