extends KinematicBody2D

const SPEED = 10

signal switch_tracks(direction)
signal player_death()

var canMove = true
var destinationPoint = null

onready var anim = $Anim
onready var enemyDetect = $EnemyDetection
onready var deathSound = $DeathSound
onready var moveSound = $MoveSound


func _physics_process(delta):
	if canMove:
		if Input.is_action_just_pressed("move_left"):
			signalMove(-1)
		elif Input.is_action_just_pressed("move_right"):
			signalMove(1)
		
	if destinationPoint:
		moveToDestinationPoint()
		
		
func moveToDestinationPoint():
	var move = destinationPoint - position
	if move.x < 1 && move.x > -1:	# stop moving and snap to destination
		position = destinationPoint
		destinationPoint = null
	else:
		move_and_slide(move * SPEED)
	
	
func playMoveAnimation():
	anim.play("move")
	
	
func signalMove(dir):
	if anim.is_playing():
		anim.stop()
	if moveSound.is_playing():
		moveSound.stop()
	moveSound.play()
	
	emit_signal("switch_tracks", dir)
	
	
func initAlive():
	visible = true
	canMove = true
	enemyDetect.set_deferred("monitoring", true)
	
func initDeath():
	visible = false
	canMove = false
	enemyDetect.set_deferred("monitoring", false)
	
	
func setCanMove(val):
	canMove = val		


func _on_EnemyDetection_body_entered(body):
	if body.is_in_group("enemy"):
		deathSound.play()


func _on_DeathSound_finished():
	emit_signal("player_death")
