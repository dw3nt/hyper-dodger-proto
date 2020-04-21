extends Control

signal play_game


func _on_Quit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	emit_signal("play_game")
