extends Control

signal settings_main_menu

onready var anim = $Anim


func startUp():
	anim.play("fade_in")
	
	
func tearDown():
	anim.play("fade_out")


func _on_MainMenu_pressed():
	emit_signal("settings_main_menu")
