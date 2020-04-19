extends KinematicBody2D

const SPEEDS = [175, 100, 50]	# close, normal, far speeds

var frame

onready var sprite = $Sprite


func _ready():
	rotation_degrees = randi() % 360
	frame = randi() % sprite.hframes
	sprite.frame = frame
	
	
func _physics_process(delta):
	move_and_slide(Vector2(0, SPEEDS[frame]))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
