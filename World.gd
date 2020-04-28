extends Node

var activeScreen

onready var splashTimer = $SplashTimer
onready var anim = $Anim
onready var mainMenu = $Screens/MainMenu
onready var game = $Screens/Game
onready var gameOver = $Screens/GameOver
onready var credits = $Screens/CreditScreen
onready var buttonClickSound = $ButtonClickSound


func _ready():
	mainMenu.connect("play_game", self, "_on_MainMenu_play_game")
	mainMenu.connect("credit_pressed", self, "_on_MainMenu_credit_pressed")
	game.connect("gameplay_ended", self, "_on_Game_gameplay_ended")
	gameOver.connect("retry_game", self, "_on_GameOver_retry_game")
	gameOver.connect("main_menu_pressed", self, "_on_GameOver_main_menu_pressed")
	credits.connect("credit_main_menu", self, "_onCredits_credit_main_menu")
	
	
func playButtonClick():
	if buttonClickSound.is_playing():
		buttonClickSound.stop()
	buttonClickSound.play()
	
	
func switchScreens(goToScreen):
	if activeScreen:
		activeScreen.tearDown()
		
	goToScreen.startUp()
	activeScreen = goToScreen
	
	
func _on_MainMenu_play_game():
	playButtonClick()
	switchScreens(game)
	
	
func _on_MainMenu_credit_pressed():
	playButtonClick()
	switchScreens(credits)
	
	
func _on_Game_gameplay_ended():
	switchScreens(gameOver)
	gameOver.score = game.points


func _on_GameOver_retry_game():
	playButtonClick()
	switchScreens(game)


func _on_GameOver_main_menu_pressed():
	playButtonClick()
	switchScreens(mainMenu)
	
	
func _onCredits_credit_main_menu():
	playButtonClick()
	switchScreens(mainMenu)


func _on_SplashTimer_timeout():
	anim.play("splash_fade")


func _on_Anim_animation_finished(anim_name):
	switchScreens(mainMenu)
