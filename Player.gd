extends Node2D

signal switch_tracks(direction)


func _physics_process(delta):
	if Input.is_action_just_pressed("move_left"):
		emit_signal("switch_tracks", -1)
	elif Input.is_action_just_pressed("move_right"):
		emit_signal("switch_tracks", 1)
