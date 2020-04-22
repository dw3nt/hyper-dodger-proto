extends Node

signal gameplay_ended

const ENEMY_SCENE = preload("res://Enemy.tscn")
const GAME_OVER_SCENE = preload("res://GameOver.tscn")
const PLAYER_SCENE = preload("res://Player.tscn")

const STD_POINT_INCREASE = 10
const PLAYER_Y = 666
const ENEMY_Y = -64
const COUNTDOWN_START = 3
var points setget setPoints
var trackPosX = []
var playerTrackPosKey
var countdown setget setCountdown

onready var uiWrap = $UI
onready var tracksWrap = $DodgeTracks
onready var player = $Player
onready var enemyWrap = $Enemies
onready var pointsLabel = $UI/BottomContainer/BottomData/HBoxContainer/PointsLabel
onready var countdownLabel = $UI/CenterContainer/CountdownLabel
onready var pointsTimer = $IncreasePoints
onready var enemySpawnTimer = $SpawnEnemy
onready var gameStartCountdown = $GameStartCountdown
onready var anim = $Anim


func _ready():
	randomize()
	for track in tracksWrap.get_children():
		trackPosX.push_back(track.position.x)
		
	trackPosX.sort()	# in case track nodes ever get out of order
	resetPlayer()
	player.connect("switch_tracks", self, "_on_Player_switch_track")
	player.connect("player_death", self, "_on_Player_player_death")
	
	
func startUp():
	anim.play("fade_in")
	clearEnemies()
	player.initAlive()
	resetPlayer()
	
	self.points = 0
	
	self.countdown = COUNTDOWN_START
	countdownLabel.visible = true
	gameStartCountdown.start()
	
	
func tearDown():
	anim.play("fade_out")
	player.initDeath()
	
	enemySpawnTimer.stop()
	pointsTimer.stop()
	
	
func startGameplay():
	countdownLabel.visible = false
	gameStartCountdown.stop()
	
	player.canMove = true
	enemySpawnTimer.start()
	pointsTimer.start()
	
	
func resetPlayer():
	player.canMove = false
	playerTrackPosKey = ceil(trackPosX.size() / 2)
	player.position = Vector2(trackPosX[playerTrackPosKey], PLAYER_Y)
	
	
func movePlayer(dir):
	if player.canMove:
		var newKey = playerTrackPosKey + dir
		if newKey >= 0 && newKey < trackPosX.size():
			playerTrackPosKey = newKey
			player.destinationPoint = Vector2(trackPosX[playerTrackPosKey], PLAYER_Y)
			player.playMoveAnimation()
			
			
func clearEnemies():
	for inst in enemyWrap.get_children():
		inst.queue_free()
		
		
func setPoints(val):
	pointsLabel.text = "Points: " + str(val)
	points = val
	
	
func setCountdown(val):
	countdown = val
	if countdown > 0:
		countdownLabel.text = str(countdown)
	else:
		countdownLabel.text = "GO!"
	
	
func _on_Player_switch_track(dir):
	movePlayer(dir)
	
	
func _on_Player_player_death():
	emit_signal("gameplay_ended")


func _on_SpawnEnemy_timeout():
	var key = randi() % trackPosX.size()
	var inst = ENEMY_SCENE.instance()
	inst.position = Vector2(trackPosX[key], ENEMY_Y)
	enemyWrap.add_child(inst)
	
	if points > 100:
		var newWait = 1 - (points / 100 * 0.1)	
		enemySpawnTimer.wait_time = max(newWait, 0.2)


func _on_LeftControl_pressed():
	movePlayer(-1)


func _on_RightControl_pressed():
	movePlayer(1)


func _on_IncreasePoints_timeout():
	self.points += STD_POINT_INCREASE


func _on_StartCountdown_timeout():
	self.countdown -= 1
	if countdown < 0:
		startGameplay()
