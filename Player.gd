extends KinematicBody2D

const SPEED = 10
const BASE_ROTATE = 0.01745

signal switch_tracks(direction)
signal player_death()

var canMove = true
var destinationPoint = null

onready var baseSprite = $Base
onready var anim = $Anim
onready var enemyDetect = $EnemyDetection
onready var deathSound = $DeathSound
onready var moveSound = $MoveSound


func _process(delta):
	baseSprite.rotate(BASE_ROTATE)


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
	moveSound.play()
	
	
func signalMove(dir):
	if anim.is_playing():
		anim.stop()
	
	emit_signal("switch_tracks", dir)
	
	
func initAlive():
	modulate = Color(1, 1, 1, 1)
	scale = Vector2(1, 1)
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
		canMove = false
		deathSound.play()
		anim.play("death")


func _on_DeathSound_finished():
	emit_signal("player_death")
