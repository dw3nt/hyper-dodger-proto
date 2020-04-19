extends KinematicBody2D

const SPEED = 300
const ROTATE = 36


func _physics_process(delta):
	rotation += ROTATE
	move_and_collide(Vector2(0, SPEED) * delta)
