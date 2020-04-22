extends Control

signal retry_game
signal main_menu_pressed

var score = 0 setget setScore

onready var scoreLabel = $CenterContainer/VBoxContainer/GameOverWrap/ScoreLabel
onready var anim = $Anim


func playFadeIn():
	anim.play("fade_in")


func setScore(val):
	scoreLabel.text = "Score: " + str(val)
	score = val


func _on_Retry_pressed():
	emit_signal("retry_game")
	
	
func _on_MainMenu_pressed():
	emit_signal("main_menu_pressed")


func _on_Quit_pressed():
	get_tree().quit()
