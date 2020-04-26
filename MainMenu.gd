extends Control

signal play_game
signal credit_pressed

onready var anim = $Anim


func startUp():
	anim.play("fade_in")
	
	
func tearDown():
	anim.play("fade_out")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	emit_signal("play_game")


func _on_Credit_pressed():
	emit_signal("credit_pressed")
