extends Control

signal retry_game
signal main_menu_pressed

var score = 0 setget setScore

onready var highscoreLabel = $CenterContainer/VBoxContainer/GameOverWrap/ScoresContainer/HighscoreLabel
onready var scoreLabel = $CenterContainer/VBoxContainer/GameOverWrap/ScoresContainer/ScoreLabel
onready var anim = $Anim


func startUp():
	anim.play("fade_in")
	
	
func tearDown():
	anim.play("fade_out")


func setScore(val):
	var scoreData = DataSaver.readScores()
	var highscore = scoreData["highscore"]
	
	scoreLabel.text = "Score: " + str(val)
	if val > highscore:
		highscoreLabel.text = "New Highscore!"
		DataSaver.writeScores(val, val)
	else:
		highscoreLabel.text = "Highscore: " + str(highscore)
		DataSaver.writeScores(val, highscore)
	
	score = val


func _on_Retry_pressed():
	emit_signal("retry_game")
	
	
func _on_MainMenu_pressed():
	emit_signal("main_menu_pressed")


func _on_Quit_pressed():
	get_tree().quit()
