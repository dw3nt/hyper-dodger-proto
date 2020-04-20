extends Control

var score = 0 setget setScore

onready var scoreLabel = $CenterContainer/VBoxContainer/ScoreLabel


func setScore(val):
	scoreLabel.text = "Score: " + str(val)
	score = val


func _on_TouchScreenButton_pressed():
	get_tree().reload_current_scene()
