extends Node2D

signal switch_tracks(direction)
signal player_death()


func _physics_process(delta):
	if Input.is_action_just_pressed("move_left"):
		emit_signal("switch_tracks", -1)
	elif Input.is_action_just_pressed("move_right"):
		emit_signal("switch_tracks", 1)


func _on_Collision_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("player_death")
		queue_free()
